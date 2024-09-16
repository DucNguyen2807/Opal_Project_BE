using Microsoft.IdentityModel.Tokens;
using Opal_Exe201.Data.Models;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Utils
{
    public static class JWTGenerate
    {
        private static string Key = "j0ry6WqdAsqBWKOkBmgAx3Ded8WQSRr2yCC6IjgBgSZYId3VjFXHOU9efwmsEZMF";
        private static string Issuser = "OpalUser";
        private static string Audience = "OpalUser";

        public static string GenerateToken(User user)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(Key);
            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]{
                    new Claim(ClaimTypes.Name, user.Username),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim("UserId", user.UserId.ToString()),
                    //roles
                    

                }),
                Expires = DateTime.UtcNow.AddMinutes(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes), SecurityAlgorithms.HmacSha512Signature)
            };
            var token = jwtTokenHandler.CreateToken(tokenDescription);
            return jwtTokenHandler.WriteToken(token);
        }

        public static string DecodeToken(string jwtToken, string nameClaim)
        {
            var _tokenHandler = new JwtSecurityTokenHandler();
            Claim? claim = _tokenHandler.ReadJwtToken(jwtToken).Claims.FirstOrDefault(selector => selector.Type.ToString().Equals(nameClaim));
            return claim != null ? claim.Value : "Error!!!";
        }


    }
}
