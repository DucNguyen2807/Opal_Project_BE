using MailKit.Security;
using MimeKit;
namespace Opal_Exe201.Service.Services.EmailServices
{
    public class EmailService : IEmailService
    {
        public async Task<bool> SendEmail(string Email, string Subject, string Html)
        {
            try
            {
                var toEmail = Email;
                string from = "opal.theapp@gmail.com";
                string pass = "vcor qbmz ojsw tfmw";
                MimeMessage message = new();
                message.From.Add(MailboxAddress.Parse(from));
                message.Subject = "[Opal] " + Subject;
                message.To.Add(MailboxAddress.Parse(toEmail));
                message.Body = new TextPart(MimeKit.Text.TextFormat.Html)
                {
                    Text = Html
                };
                using MailKit.Net.Smtp.SmtpClient smtp = new();
                await smtp.ConnectAsync("smtp.gmail.com", 587, SecureSocketOptions.StartTls);
                await smtp.AuthenticateAsync(from, pass);
                await smtp.SendAsync(message);
                await smtp.DisconnectAsync(true);
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }
}