From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3.14-rt] sas-ata/isci: dont't disable interrupts in qc_issue
 handler
Date: Wed, 18 Feb 2015 10:33:34 -0500
Message-ID: <54E4B0CE.1020508@windriver.com>
References: <1423929676-35724-1-git-send-email-paul.gortmaker@windriver.com> <20150218113803.GG28763@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:43315 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbbBRPfH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 10:35:07 -0500
In-Reply-To: <20150218113803.GG28763@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 15-02-18 06:38 AM, Sebastian Andrzej Siewior wrote:
> * Paul Gortmaker | 2015-02-14 11:01:16 [-0500]:
>=20
>> On 3.14-rt we see the following trace on Canoe Pass for
>> SCSI_ISCI "Intel(R) C600 Series Chipset SAS Controller"
>> when the sas qc_issue handler is run:
>=20
> So I have finally something that is using isci I would have assumed t=
hat
> I would be affected by this. But somehow it does not pop up=E2=80=A6

=46unny you should mention that, as I too had the same thought, since
I also did not see it on my machine with the same hardware, but I did
see it on the machine I was loaned to diagnose the issue.  I assumed
that the loaner machine had flaky media that was calling error handler
code that my machine would never run.

P.
--

>=20
> Applied.
>=20
> And we are down to
> | $ git grep -c 'local_irq_save\W' drivers/scsi/  | wc -l
> | 14
>=20
> I hope the others are just old things nobody is using=E2=80=A6
>=20
> Sebastian
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
