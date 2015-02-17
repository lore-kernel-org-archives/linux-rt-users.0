From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.14.x-rt] ARM: enable irq in translation/section
 permission fault handlers
Date: Tue, 17 Feb 2015 18:10:02 +0100
Message-ID: <20150217171002.GU26177@linutronix.de>
References: <1418178729-2279-1-git-send-email-yadi.hu@windriver.com>
 <1418178729-2279-2-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Yadi Hu <yadi.hu@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44419 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbBQRKF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 12:10:05 -0500
Content-Disposition: inline
In-Reply-To: <1418178729-2279-2-git-send-email-yadi.hu@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Yadi Hu | 2014-12-10 10:32:09 [+0800]:

>This simple program....
>
>int main() {
>   *((char*)0xc0001000) = 0;
>};

Thanks for the test programm and the well done description. I applied
the patch.

Sebastian
