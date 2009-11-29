From: "Ardhan Madras" <ajhwb@knac.com>
Subject: Re: PREEMPT_RT on X/GTK+
Date: Sat, 28 Nov 2009 22:41:26 -0800
Message-ID: <20091128224126.321DF1F1@resin10.mta.everyone.net>
Reply-To: <ajhwb@knac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: "Carsten Emde" <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imta-38.everyone.net ([216.200.145.38]:47385 "EHLO
	omta0109.mta.everyone.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751600AbZK2Gfi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Nov 2009 01:35:38 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten,

The control application has custom keyboard device, basically it's a PS/2 keyboard that only has special key need for it's operation. My problem is in certain condition, the application respond to the keyboard's key pressing-event is unpredictable, sometime it was late to caught the event for about 0.5 - 1 second, the application does not consume a lot of CPU time, it just wait for the pressed key. I think this a normal X behaviour.

             Ardhan



--- Carsten.Emde@osadl.org wrote:

From:	Carsten Emde <Carsten.Emde@osadl.org>
To:	Ardhan Madras <ajhwb@knac.com>
CC:	RT-Users <linux-rt-users@vger.kernel.org>
Subject: Re: PREEMPT_RT on X/GTK+
Date:	Sat, 28 Nov 2009 14:23:56 +0100

Ardhan,

> Is there special care when using PREEMPT_RT patch in X/GTK+ 
> applications? [..]
In general, no other care than with any other RT application.

Do you wish the GUI to immediately and smoothly reflect important
states of your control application? In this case, you should
consider that the display only changes, if both the GTK+ application
and the X server react in time. For this purpose, it is sometimes
recommended to set the priority of the X server a little less
than that of the control application. Never assign the highest
priority of the system to the X server, since this may completely
block the server. A priority of < 49, however, is normally safe.

	Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html




_____________________________________________________________
Listen to KNAC, Hit the Home page and Tune In Live! ---> http://www.knac.com
