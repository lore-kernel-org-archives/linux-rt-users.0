From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0.14-rt31
Date: Thu, 12 Jan 2012 11:18:34 +0100
Message-ID: <201201121118.34776.tim.sander@hbm.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "LKML" <linux-kernel@vger.kernel.org>,
	"RT" <linux-rt-users@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:45450 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751153Ab2ALKTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jan 2012 05:19:22 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <1324525237.5916.114.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven

I have just tested 3.0.14 with some local adaptions. Unfortunatly there=
 we=20
have still two errors here:
Reboot ( of upstart) fails sometimes fails with the following message:
"reboot: Unable to execute shutdown: Bad address"
This problem can probably easily worked around by catching a failed exe=
cution=20
and retry, but i am afraid that execution fails more often in other pla=
ces and=20
leads to silent functionality failures.

and the running wild ksoftirqd0 most probably after the kernel message:
"sched: RT throttling activated"
It also seems as if the system looks up after running ifconfig. But it =
seems as=20
if the error only shows up most of the times if i am not around.

Best regards
Tim


Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, =
Germany | www.hbm.com=20

Registered as GmbH (German limited liability corporation) in the commer=
cial register at the local court of Darmstadt, HRB 1147 =20
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of =
the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregist=
er des Amtsgerichts Darmstadt unter HRB 1147=20
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhor=
st | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely fo=
r the addressee. If you are not the intended recipient, please let me k=
now and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und ledigli=
ch f=FCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Emp=
faenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
