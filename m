From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: Minor page faults from pthread_create() aka still problems with 3.0.12-rt30
Date: Mon, 9 Jan 2012 11:35:39 +0100
Message-ID: <201201091135.39733.tim.sander@hbm.com>
References: <4F075DA5.1070307@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/Plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: "Adrian Knoth" <adi@drcomp.erfurt.thur.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:26963 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752381Ab2AIKg0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jan 2012 05:36:26 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <4F075DA5.1070307@drcomp.erfurt.thur.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi
> Simply running the example causes roughly 30 minor page faults. When =
I
> manually allocate stack memory for the stack (after mlockall() and
> mallopt have been called) and use pthread_attr_setstack() before call=
ing
> pthread_create(), minor page faults drop to 2.
>=20
> Does anybody happen to know what is causing these remaining two page
> faults? My only guess so far is kernel memory to hold some
> organizational data for the new thread after clone() has been invoked=
,
> but this could also be completely wrong.
>=20
> Note that I don't need to get page faults down to 0, I'm only looking
> for an explanation to understand the issue at hand to confirm that
> pthread_create() must not be used from an RT context.
While unfortunatly i can't help i've got the impression that something =
is=20
still strange with 3.0.12pmx-rt30. (This is on a arm i.mx35 with some=20
platform adaptations and a cyclic clock interrupt.). I haven't build a =
newer=20
version of 3.0-rt yet.

See my mail where i describe this problem here.
https://lkml.org/lkml/2011/12/7/657

I am ocasionally also seeing a ksoftirqd/0 running on as much cpu as it=
 gets.
This is always when i see the message: sched: RT throttling activated

Not the best start into the new year :-(.

Best regards
Tim

Please ignore:

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
