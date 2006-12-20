From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [patch 0/4] ARM: OMAP: Add clocksource and clockevent driver for
 OMAP
Date: Wed, 20 Dec 2006 10:17:59 +0100
Message-ID: <4588FFC7.5060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, David Brownell <david-b@pacbell.net>,
	Daniel Walker <dwalker@mvista.com>,
	Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:18894 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964953AbWLTJSD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Dec 2006 04:18:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2593898nfa
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2006 01:18:01 -0800 (PST)
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

the following patches add clocksource and clockevent driver
for ARM based TI OMAP devices.

They are against linux-2.6.19 + patch-2.6.20-rc1 +
patch-2.6.20-rc1-rt0. The clocksource patch went through
several review cycles on OMAP list.

Dirk
