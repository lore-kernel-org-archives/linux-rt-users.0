From: Gregoire Gentil <gregoire@gentil.com>
Subject: "g_serial: fix deadlock with PREEMPT_RT enabled" still not integrated
Date: Sun, 02 Sep 2012 23:10:23 -0700
Message-ID: <504449CF.5050604@gentil.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de> <20120902194911.GT28643@pengutronix.de>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:42875 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab2ICGQc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Sep 2012 02:16:32 -0400
Received: from [192.168.10.5] (c-69-181-223-70.hsd1.ca.comcast.net [69.181.223.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTPSA id A4C1E1402476E
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Sep 2012 08:10:25 +0200 (CEST)
In-Reply-To: <20120902194911.GT28643@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I think that the g_serial patch is still not integrated and it's still=20
needed at least as I experienced it on 3.4-rt17 on ARM:
http://www.spinics.net/lists/linux-rt-users/msg07158.html

Here is an update of the patch:

--- a/drivers/usb/gadget/u_serial.c	2012-08-29 12:17:48.607922510 -0700
+++ b/drivers/usb/gadget/u_serial.c	2012-08-29 12:23:21.305572267 -0700
@@ -554,7 +554,15 @@
  	 * a workqueue, so we won't get callbacks and can hold port_lock
  	 */
  	if (tty && do_push)
-		tty_flip_buffer_push(tty);
+		/*
+		* Drop the lock here since it might end up calling
+		* gs_flush_chars, which takes the lock.
+		*/
+		spin_unlock_irq(&port->port_lock);
+ 		tty_flip_buffer_push(tty);
+		spin_lock_irq(&port->port_lock);
+		/* tty may have been closed */
+		tty =3D port->port_tty;


  	/* We want our data queue to become empty ASAP, keeping data


Gr=E9goire

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
