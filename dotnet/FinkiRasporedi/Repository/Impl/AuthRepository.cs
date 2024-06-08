using FinkiRasporedi.Models.Identity;
using FinkiRasporedi.Repository.Data;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FinkiRasporedi.Repository.Impl
{
    public class AuthRepository : IAuthRepository
    {
        private readonly UserManager<Student> _userManager;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IConfiguration _configuration;



        public AuthRepository(
            UserManager<Student> userManager,
            ApplicationDbContext context,
            IHttpContextAccessor httpContextAccessor,
            IConfiguration configuration
        )
        {
            _userManager = userManager;
            _httpContextAccessor = httpContextAccessor;
            _configuration = configuration;
            _configuration = configuration;
            _configuration = configuration;
        }

        public async Task<Student> RegisterAsync(StudentRegistrationModel registrationModel)
        {
            var student = new Student { UserName = registrationModel.Username, Email = registrationModel.Email };
            var result = await _userManager.CreateAsync(student, registrationModel.Password);
            if (result.Succeeded)
            {
                return student;
            }
            else
            {
                throw new Exception("Failed to register student.");
            }
        }

        public async Task<Student> LoginAsync(string username, string password)
        {
            var user = await _userManager.FindByNameAsync(username);
            if (user != null && await _userManager.CheckPasswordAsync(user, password))
            {
                return user;
            }
            else
            {
                return null;
            }
        }


        public string GetTokenFromHeader()
        {
            var authorizationHeader = _httpContextAccessor.HttpContext.Request.Headers["Authorization"];
            return authorizationHeader.FirstOrDefault(h => h.StartsWith("Bearer "))
               ?.Split(' ')
               ?.LastOrDefault();
        }

        public string ValidateTokenAndGetUserId()
        {
            var token = this.GetTokenFromHeader();
            if (token == null)
            {
                throw new UnauthorizedAccessException("Invalid token");
            }

            var jwtSettings = _configuration.GetSection("JwtSettings");
            var secretKey = jwtSettings.GetValue<string>("Secret");
            var audience = jwtSettings.GetValue<string>("Audience");
            var tokenValidationParams = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey)),
                ValidIssuer = audience,
                ValidAudience = audience
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var principal = tokenHandler.ValidateToken(token, tokenValidationParams, out var validatedToken);

            var userId = principal.Claims.FirstOrDefault(claim => claim.Type == ClaimTypes.Name)?.Value;
            return userId;
        }

        public bool ValidateTokenAndCompareUser(string userId)
        {
            String tokenUserId = this.ValidateTokenAndGetUserId();
            return tokenUserId == userId;
        }


    }
}
