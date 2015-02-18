From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rtmutex: enable deadlock detection in ww_mutex_lock
 functions
Date: Wed, 18 Feb 2015 10:43:36 +0100
Message-ID: <20150218094336.GB28763@linutronix.de>
References: <20150120200229.GA17473@gbitten>
 <CAP=VYLq2JS0072Y0P=A+oWrt2MHjy42uG0LgQvfyHXfzf7PXeg@mail.gmail.com>
 <54C657FB.2060106@gmail.com>
 <20150217174640.GZ26177@linutronix.de>
 <54E3DA6D.1000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46959 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbBRJnk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 04:43:40 -0500
Content-Disposition: inline
In-Reply-To: <54E3DA6D.1000204@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Gustavo Bittencourt | 2015-02-17 22:18:53 [-0200]:

>It is still required.
Applied. Please let me know how that nouveau driver behaves. Last thing
I know is that it randomly explodes.

Sebastian
