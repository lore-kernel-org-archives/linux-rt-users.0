From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: rt_mutex_lock
Date: Fri, 14 May 2010 09:24:43 +0530
Message-ID: <AANLkTimUWsFLfOLEFlKzcRPtX0Skgea99q-Cbpu_ZGfk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59836 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0ENEBJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 00:01:09 -0400
Received: by gyg13 with SMTP id 13so997550gyg.19
        for <linux-rt-users@vger.kernel.org>; Thu, 13 May 2010 21:01:07 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 I used rt_mutex_lock to protect
one critical section in softirq-rx code . There is some kernel crash
happens in the critical section .

In my OOPs analysis i found that ..

PC- > my function code in critical section
LR -> rt_mutex_unlock .

Why LR is rt_mutex unlock ? Before unlocking , preemption can happen ?

Thanks,
Ratheesh
