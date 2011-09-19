From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0.4-rt14
Date: Mon, 19 Sep 2011 11:03:52 +0200
Message-ID: <201109191103.52843.tim.sander@hbm.com>
References: <alpine.LFD.2.02.1109150047290.2723@ionos>
Mime-Version: 1.0
Content-Type: text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "LKML" <linux-kernel@vger.kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:18223 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753550Ab1ISJKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Sep 2011 05:10:39 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <alpine.LFD.2.02.1109150047290.2723@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas

Thanks for the new release. We've been testing your release here. We fo=
und=20
that the minimum timer resolution on a vanilla 3.0.4-rt14 is about 16ms=
=2E I=20
tried switching on hr timers but even with them the timer behaviour was=
 the=20
same. So i suspect that there is something strange going on concerning =
the=20
timers. The tests done where on the pcm04 arm11 platform.

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
