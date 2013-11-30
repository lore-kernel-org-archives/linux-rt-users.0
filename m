From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Sat, 30 Nov 2013 21:39:20 +0100
Message-ID: <20131130203920.GB24080@linutronix.de>
References: <52999A44.7060103@localhost>
 <529A1511.5050801@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37936 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3K3Uj0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Nov 2013 15:39:26 -0500
Content-Disposition: inline
In-Reply-To: <529A1511.5050801@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Carsten Emde | 2013-11-30 17:40:49 [+0100]:

># addr2line -e vmlinux 0xffffffff81298301
>/usr/src/kernels/linux-3.12.0-rt2/drivers/acpi/ec.c:186
>
>        if (t->wlen > t->wi) {
>                if ((status & ACPI_EC_FLAG_IBF) == 0)
>                        acpi_ec_write_data(ec,
>---->                           t->wdata[t->wi++]);
>                else
>                        goto err;

based on the assembly, I *think* this is 
 t->wdata[x]

wher X is outside of wdata's range. But then  the pointer is almost
NULL. Could one of you check with the acpi folks if they know some
tricks how to debug this ACPI thingy?

Is this any help?

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a06d983..d3add07 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -175,16 +175,19 @@ static void start_transaction(struct acpi_ec *ec)
 static void advance_transaction(struct acpi_ec *ec, u8 status)
 {
 	unsigned long flags;
-	struct transaction *t = ec->curr;
+	struct transaction *t;
 
 	spin_lock_irqsave(&ec->lock, flags);
+	t = ec->curr;
 	if (!t)
 		goto unlock;
 	if (t->wlen > t->wi) {
-		if ((status & ACPI_EC_FLAG_IBF) == 0)
+		if ((status & ACPI_EC_FLAG_IBF) == 0) {
+			if (WARN_ON_ONCE(!t->wdata))
+				goto err;
 			acpi_ec_write_data(ec,
 				t->wdata[t->wi++]);
-		else
+		} else
 			goto err;
 	} else if (t->rlen > t->ri) {
 		if ((status & ACPI_EC_FLAG_OBF) == 1) {

Sebastian
