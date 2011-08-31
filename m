From: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Subject: does nohz still need to be disabled?
Date: Wed, 31 Aug 2011 13:50:21 +0200
Message-ID: <4E5E1FFD.4070604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59406 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001Ab1HaLuY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Aug 2011 07:50:24 -0400
Received: by wyh22 with SMTP id 22so63016wyh.19
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Aug 2011 04:50:23 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey all,

I've been running 3.0.4-rt12 forsome time now without issues and nohz enabled,
with RCU_BOOST is set to 80 (same level as my emergency serial console),
is there still a reason why nohz needs to be disabled?

~Maarten
