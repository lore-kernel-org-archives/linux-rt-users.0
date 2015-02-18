From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: [PATCH] rtmutex: enable deadlock detection in ww_mutex_lock functions
Date: Tue, 17 Feb 2015 22:18:53 -0200
Message-ID: <54E3DA6D.1000204@gmail.com>
References: <20150120200229.GA17473@gbitten> <CAP=VYLq2JS0072Y0P=A+oWrt2MHjy42uG0LgQvfyHXfzf7PXeg@mail.gmail.com> <54C657FB.2060106@gmail.com> <20150217174640.GZ26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:38827 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbBRAS6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 19:18:58 -0500
Received: by mail-qg0-f50.google.com with SMTP id e89so30718375qgf.9
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 16:18:58 -0800 (PST)
In-Reply-To: <20150217174640.GZ26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On 02/17/2015 03:46 PM, Sebastian Andrzej Siewior wrote:
> * Gustavo Bittencourt | 2015-01-26 13:06:35 [-0200]:
>
>> I'm not sure if those patches are connected, so I am posting my
>> findings for anyone.
> could please re-test again v3.18-RT and tell if this patch is still
> required or not?
>
> Sebastian
It is still required.
