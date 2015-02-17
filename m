From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rtmutex: enable deadlock detection in ww_mutex_lock
 functions
Date: Tue, 17 Feb 2015 18:46:40 +0100
Message-ID: <20150217174640.GZ26177@linutronix.de>
References: <20150120200229.GA17473@gbitten>
 <CAP=VYLq2JS0072Y0P=A+oWrt2MHjy42uG0LgQvfyHXfzf7PXeg@mail.gmail.com>
 <54C657FB.2060106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44533 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbBQRqn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 12:46:43 -0500
Content-Disposition: inline
In-Reply-To: <54C657FB.2060106@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Gustavo Bittencourt | 2015-01-26 13:06:35 [-0200]:

>I'm not sure if those patches are connected, so I am posting my
>findings for anyone.

could please re-test again v3.18-RT and tell if this patch is still
required or not?

Sebastian
