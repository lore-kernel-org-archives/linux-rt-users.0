From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC 00/10] make iwlwifi RT friendly
Date: Sun, 15 Dec 2013 18:46:53 +0100
Message-ID: <52ADEB0D.3080306@linutronix.de>
References: <1386750826-25219-1-git-send-email-emmanuel.grumbach@intel.com> <20131215154843.GL31090@linutronix.de> <52ADEAAF.3080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-rt-users@vger.kernel.org, linux-wireless@vger.kernel.org
To: Emmanuel Grumbach <egrumbach@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56402 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab3LORq6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Dec 2013 12:46:58 -0500
In-Reply-To: <52ADEAAF.3080107@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2013 06:45 PM, Emmanuel Grumbach wrote:
> No we don't. The primary interrupt just tells the hardware to stop
> firing interrupts and wakes up the thread as written above.

Sounds great then.

Sebastian
