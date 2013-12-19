From: Ruud Commandeur <RCommandeur@clb.nl>
Subject: Applying rt-patches
Date: Thu, 19 Dec 2013 09:35:33 +0100
Message-ID: <15AE5A936F5E3A42A9144E66875A0A8938ADEC@server1-derijp.CLB-Benelux.lokaal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.clb-benelux.nl ([91.221.230.194]:63869 "EHLO mail.clb.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab3LSIk7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Dec 2013 03:40:59 -0500
Content-Class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Everyone,
 
I'm using the Linux 3.10.x kernel for a while in an ARM9 embedded
system. I keep this kernel up-to-date by using incremental patches, with
3.10.24 being the last version. I'm thinking of switching to the
RT-kernel for better real-time behavior, but I have a few questions how
to do that:
 
On a clean 3.10.24 kernel, I assume I should use the
"patch-3.10.24-rt22.patch" archive (or the "patches-3.10.24-rt22" for a
collection of single patch files).
But what if a 3.10.25 kernel is released? Should I first apply the
incremental patch for the kernel and then the incremental patch for the
rt-part? Or should the 3.10.24-rt patch be reverted before applying the
kernel patch to prevent conflicts?

Sorry if the answer to my questions would be somewhere in the Wiki, I
was not able to find it myself up till now.

Thanks in advance for your reply. Regards,

Ruud
