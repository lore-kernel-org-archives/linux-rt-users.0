From: Raz <raziebe@gmail.com>
Subject: [DISCUSS : vxwork to linux]
Date: Sat, 14 Aug 2010 00:27:28 +0300
Message-ID: <AANLkTikMjYAMZEvsYwJ0mQ7LyU5Ko4GizvjM1WqeZmdt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ofer Kruzel <ofer@bitband.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37308 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab0HMV1s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 17:27:48 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so199675iwn.19
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Aug 2010 14:27:48 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello rt. I wish to write a paper that describes what it means to port
from vxworks to linux rt in all apects but from your experience. The be=
llow
is a list of questions.

why did you port ? lack of hardware support ?

Is your system soft real time or hard time system ?

Can you estimate how many lines of code were ported ?

Was there an effort to teach the vxwork engineers linux ? did it
succeed / partialy succeed ?
If new engineers were recruited, was it difficult to find linux rt
programmers ? how long did
it take to recruit ?

Was the same team structure preserved or a new hirarchy created ?

how long did it take to the first linux product ?

Did you release new vxworks versions while migrating ? after the
migration is done ?
=A0=A0=A0=A0=A0=A0=A0=A0 if so , do you have the same engineers support=
ing the old code ?

What are the information resources you used for that ?
Did you consult with professionals ? how did you reach a decision what
sort of rt flavor to use ?

Were new positions/skills required=A0 ? Did you recruit platform
engineers ? Kernel engineers ?

Did you use porting libraries or a nother solution ? did you change
the system design ? Did you use other programming languages other than
c and c++
to migrate ?

once the porting was complete can you estimate, does it take the same
effort to release
a product ?

What was the clients response when they were told you changed Os ? Did
they know or care ?

Is the linux product required to do more than the vx works product?

Were all engineers using the same operating system or did some
programmers use linux while others running
windows ? Did it matter ?

Were there any logistics changes due to the porting ? Did the IT
department took part , like switching exchange server
to something else ? vpn ?

Did you use the same source control system ? bug tracking system ?

Did you keep your code closed or is it open/partialy open ?

thank you
raz
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
