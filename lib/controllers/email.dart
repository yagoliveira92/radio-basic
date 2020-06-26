// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// class Email {
//   var smtpServer;

//   Email() {
//     smtpServer = SmtpServer('mail.igrejaemaracaju.com.br',
//         allowInsecure: true,
//         ignoreBadCertificate: true,
//         port: 587,
//         username: 'radio@igrejaemaracaju.com.br',
//         password: 'krtgQ[,XJx3!');
//   }

//   Future<bool> sendMessage(
//       String mensagem, String destinatario, String assunto) async {
//     final message = Message()
//       ..from = Address('radio@igrejaemaracaju.com.br', 'Nome')
//       ..recipients.add(destinatario)
//       ..subject = assunto
//       ..text = mensagem;

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());

//       return true;
//     } on MailerException catch (e) {
//       print('Message not sent.');
//       for (var p in e.problems) {
//         print('Problem: ${p.code}: ${p.msg}');
//       }
//       return false;
//     }
//   }
// }
