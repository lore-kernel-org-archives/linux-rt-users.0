From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: RT Throtteling with PREEMT-RT on UBIFS root fs update
Date: Thu, 17 Nov 2011 14:54:18 +0100
Message-ID: <201111171454.18742.tim.sander@hbm.com>
References: <201111111056.53803.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>,
	"LKML" <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:33816 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757642Ab1KQNzp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Nov 2011 08:55:45 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <201111111056.53803.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi=20

This is just a followup=20
> We are having a problem with a slightly patched (some platform patche=
s,
> newest stable ubifs patches) 3.0.7-rt20 kernel after updating the fir=
mware
> on the first boot we get a message:
> sched: RT throttling activated
> and ksoftirqd/0 taking 95% of the cpu time.
RT throtteling is still activate with 3.0.9-rt25 (+ ubifs stable patche=
s) but=20
now  ksoftirqd/0 is not going berserk.
> Interestingly this only happens after the ubifs root has been updated=
 on
> the first boot (and not allways). Subsequent boot problems have not b=
een
> seen.
Ok the only nitpik that is left, that the processor activates rt thrott=
eling=20
after the first boot with updated ubifs image.=20
> Any ideas whats causing this?
Well it can be said that it is not ksoftirqd/0 going berserk which is=20
triggering this. So i guess when this message is printed it just shows =
that=20
the cpu had been temporarily overloded with work in interrupt context.
Is there more harm to expect from this message or save to ignore if the=
=20
systemload is normal again?

Best regards
Tim
=20
> Sorry for noise below, please ignore:

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
