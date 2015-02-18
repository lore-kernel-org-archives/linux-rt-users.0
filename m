From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.14-rt] sas-ata/isci: dont't disable interrupts in
 qc_issue handler
Date: Wed, 18 Feb 2015 12:38:03 +0100
Message-ID: <20150218113803.GG28763@linutronix.de>
References: <1423929676-35724-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47539 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbBRLiF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 06:38:05 -0500
Content-Disposition: inline
In-Reply-To: <1423929676-35724-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2015-02-14 11:01:16 [-0500]:

>On 3.14-rt we see the following trace on Canoe Pass for
>SCSI_ISCI "Intel(R) C600 Series Chipset SAS Controller"
>when the sas qc_issue handler is run:

So I have finally something that is using isci I would have assumed tha=
t
I would be affected by this. But somehow it does not pop up=E2=80=A6

Applied.

And we are down to
| $ git grep -c 'local_irq_save\W' drivers/scsi/  | wc -l
| 14

I hope the others are just old things nobody is using=E2=80=A6

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
