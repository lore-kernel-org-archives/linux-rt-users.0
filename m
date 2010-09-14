From: Sergio Ruocco <ruocco@disco.unimib.it>
Subject: Re: Priority Inheritance per se?
Date: Tue, 14 Sep 2010 11:56:01 +0200
Message-ID: <4C8F46B1.1010804@disco.unimib.it>
References: <4C89D4DF.9060109@cs.tu-chemnitz.de>
Reply-To: ruocco@disco.unimib.it
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-15?Q?Martin_D=E4umler?= <mdae@cs.tu-chemnitz.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.disco.unimib.it ([149.132.176.35]:50215 "EHLO
	mail.disco.unimib.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0INKLW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 06:11:22 -0400
In-Reply-To: <4C89D4DF.9060109@cs.tu-chemnitz.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Martin D=E4umler wrote:
> [snip]

Hi Martin,

before really deciding for the use of PI, you may want to read what
Victor Yodaiken had to say:

http://www.yodaiken.com/papers-and-talks/
Against priority inheritance, Victor Yodaiken. September 23, 2004
http://www.yodaiken.com/papers/inherit.pdf

Here is a general Linux RT workshop report, with some comments on PI:
http://lwn.net/Articles/354690/

	Sergio

--=20

Dr. Sergio Ruocco   Research Fellow    http://www.disco.unimib.it/ruocc=
o
mailto:ruocco@disco.unimib.it / sergio.ruocco@gmail.com      NOMADIS La=
b
phone: +39-02-6448-7914               Mobile, embedded real-time system=
s
skype: 'sergioruocco'  Dip. di Informatica, Sistemistica e COmunicazion=
e
Building U14, room 1003  Universit=E0 degli Studi di Milano-Bicocca, It=
aly

W La ricerca http://video.google.com/videoplay?docid=3D-651877985494451=
9929

Your manuscript is both good and original; but the part that is good is
not original, and the part that is original is not good.
Samuel Johnson


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
