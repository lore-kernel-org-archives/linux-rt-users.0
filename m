From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: PREEMPT_RT on X/GTK+
Date: Sat, 28 Nov 2009 14:23:56 +0100
Message-ID: <4B11246C.4030600@osadl.org>
References: <20091127213128.FCC9A1E@resin13.mta.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT-Users <linux-rt-users@vger.kernel.org>
To: Ardhan Madras <ajhwb@knac.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55894 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbZK1OfM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Nov 2009 09:35:12 -0500
In-Reply-To: <20091127213128.FCC9A1E@resin13.mta.everyone.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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
