From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 3.0.0-1-rt-amd64: Suspend hangs
Date: Fri, 30 Sep 2011 04:48:23 -0500
Message-ID: <20110930094823.GA13652@elie>
References: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: johnohagan <mail@johnohagan.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37036 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1I3Jsc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Sep 2011 05:48:32 -0400
Received: by ywb5 with SMTP id 5so1336066ywb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2011 02:48:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110930010128.ede515e66ed1a331ad625a2a@johnohagan.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

johnohagan wrote:

> The freeze occurs with pm_test set to "processors", but not with
> "platform". 
>
> With "single no_console_suspend" on the kernel command-line and
> trying STD, the screen messages are normal up to the point of saving
> the image, and remain there after the freeze.

A natural next step would be to use some printks to find when exactly
it is freezing (as illustrated in the patch below)[2].  If it's still
not clear after that what's causing it to hang, then bisecting[1]
through the -rt patch stack can isolate the specific change that
causes it (I can walk you through that).

Good luck,
Jonathan

[1] https://git-core.googlecode.com/git-history/html/git-bisect-lk2009.html
[2] http://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s4.2.3
explains how to build a tweaked Debian kernel package.

diff --git i/kernel/power/hibernate.c w/kernel/power/hibernate.c
index 2b0c52ff8703..fb8aecc4f11d 100644
--- i/kernel/power/hibernate.c
+++ w/kernel/power/hibernate.c
@@ -260,6 +260,8 @@ static int create_image(int platform_mode)
 {
 	int error;
 
+	printk("PM debug: creating hibernation image\n");
+
 	error = dpm_suspend_noirq(PMSG_FREEZE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
@@ -267,15 +269,19 @@ static int create_image(int platform_mode)
 		return error;
 	}
 
+	printk("PM debug: create_image(): pre-snapshot:\n");
 	error = platform_pre_snapshot(platform_mode);
 	if (error || hibernation_test(TEST_PLATFORM))
 		goto Platform_finish;
 
+	printk("PM debug: create_image(): disable nonboot CPUs:\n");
 	error = disable_nonboot_cpus();
+	printk("PM debug: finished disabling nonboot CPUs\n");
 	if (error || hibernation_test(TEST_CPUS)
 	    || hibernation_testmode(HIBERNATION_TEST))
 		goto Enable_cpus;
 
+	printk("PM debug: a 'processors' test shouldn't get this far\n");
 	local_irq_disable();
 
 	system_state = SYSTEM_SUSPEND;
@@ -311,14 +317,18 @@ static int create_image(int platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
+	printk("PM debug: enabling nonboot CPUs\n");
 	enable_nonboot_cpus();
 
  Platform_finish:
+	printk("PM debug: finishing\n");
 	platform_finish(platform_mode);
 
+	printk("PM debug: resume\n");
 	dpm_resume_noirq(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
+	printk("PM debug: create_image finished\n");
 	return error;
 }
 
