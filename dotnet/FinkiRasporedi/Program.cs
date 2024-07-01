using FinkiRasporedi.Models.Identity;
using FinkiRasporedi.Models.Mailling;
using FinkiRasporedi.Repository;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Impl;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
{
    options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString));
    options.UseLazyLoadingProxies();
    options.EnableSensitiveDataLogging();
});
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

builder.Services.AddDefaultIdentity<Student>(options => options.SignIn.RequireConfirmedAccount = true)
    .AddEntityFrameworkStores<ApplicationDbContext>();
builder.Services.AddControllersWithViews();

builder.Services.AddScoped(typeof(IProfessorRepository), typeof(ProfessorRepository));
builder.Services.AddScoped(typeof(ISubjectRepository), typeof(SubjectRepository));
builder.Services.AddScoped(typeof(ICourseRepository), typeof(CourseRepository));
builder.Services.AddScoped(typeof(ISemesterRepository), typeof(SemesterRepository));
builder.Services.AddScoped(typeof(IScheduleRepository), typeof(ScheduleRepository));
builder.Services.AddScoped(typeof(IRoomRepository), typeof(RoomRepository));
builder.Services.AddScoped(typeof(ILectureRepository), typeof(LectureRepository));
builder.Services.AddScoped(typeof(IAuthRepository), typeof(AuthRepository));
builder.Services.AddTransient<IMailService, MailService>();

builder.Services.Configure<IdentityOptions>(options =>
{
    options.Password.RequireDigit = false;
    options.Password.RequireLowercase = false;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 5;
    options.Password.RequiredUniqueChars = 0;

    options.User.AllowedUserNameCharacters =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    options.Password.RequiredLength = 5;
    options.User.RequireUniqueEmail = false;
});

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
{
    var config = builder.Configuration;
    var jwtSettings = config.GetSection("JwtSettings");
    var secretKey = jwtSettings.GetValue<string>("Secret");
    var audience = jwtSettings.GetValue<string>("Audience");

    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = audience,
        ValidAudience = audience,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey))
    };
});

builder.Services.AddScoped(typeof(ILectureSlotRepository), typeof(LectureSlotRepository));



builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAnyOrigin", builder =>
    {
        builder
            .AllowAnyOrigin() // You can replace this with specific origins if needed
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});

builder.Services.AddSwaggerGen(c =>
c.SwaggerDoc("v1", new OpenApiInfo
{
    Title = "rasporedi.finki API",
    Version = "v1",
    Description = "Team project",
    Contact = new OpenApiContact
    {
        Name = "Example Contact",
        Email = "example@example.com",
        Url = new Uri("https://example.com/contact")
    }
}));

builder.Services.Configure<MailSettings>(builder.Configuration.GetSection("MailSettings"));
var app = builder.Build();
app.UseCors("AllowAnyOrigin");
app.UseSwagger();
app.UseSwaggerUI(options =>
{
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "v1");
});

var config = app.Services.GetService<IConfiguration>();


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();


app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");
app.MapRazorPages();

app.Run();