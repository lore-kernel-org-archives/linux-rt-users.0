From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0-rt6 : BUG at kernel/trmutex.c:724!
Date: Thu, 4 Aug 2011 19:04:53 +0200
Message-ID: <201108041904.53780.tim.sander@hbm.com>
References: <alpine.LFD.2.02.1107282213000.31246@ionos> <201108041834.20575.tim.sander@hbm.com> <1312475829.16729.45.camel@twins>
Mime-Version: 1.0
Content-Type: text/Plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Peter Zijlstra" <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway.hbm.com ([213.157.30.2]:10901 "EHLO hbmntx5.hbm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab1HDRFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Aug 2011 13:05:07 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1312475829.16729.45.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Donnerstag, 4. August 2011, 18:37:09 schrieb Peter Zijlstra:
> looks like it tries to use waitqueues from hardirq context, that's a
> no-no for -rt. That interrupt should be a threaded interrupt.
Ah, right: i enabled hardirq in tring to fight latency without preempt-=
rt and=20
then forgot.

Its working now with 3.0-rt7.

Thanks=20
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
ch f=C3=BCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche =
Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-M=
ail.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
