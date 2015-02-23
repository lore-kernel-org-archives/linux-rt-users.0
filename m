From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: [PATCH] rtmutex: enable deadlock detection in ww_mutex_lock functions
Date: Mon, 23 Feb 2015 13:31:17 -0300
Message-ID: <CAA8Xd+9KscOxUuOazdY=8vqnQ+oX4aayGufORR=TtFoVjb+UUQ@mail.gmail.com>
References: <20150120200229.GA17473@gbitten>
	<CAP=VYLq2JS0072Y0P=A+oWrt2MHjy42uG0LgQvfyHXfzf7PXeg@mail.gmail.com>
	<54C657FB.2060106@gmail.com>
	<20150217174640.GZ26177@linutronix.de>
	<54E3DA6D.1000204@gmail.com>
	<20150218094336.GB28763@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:44347 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbBWQbS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2015 11:31:18 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so37407294obc.11
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2015 08:31:17 -0800 (PST)
In-Reply-To: <20150218094336.GB28763@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 18, 2015 at 7:43 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Gustavo Bittencourt | 2015-02-17 22:18:53 [-0200]:
>
>>It is still required.
> Applied. Please let me know how that nouveau driver behaves. Last thing
> I know is that it randomly explodes.
>

3.18.7-rt2 is working smoothly.
