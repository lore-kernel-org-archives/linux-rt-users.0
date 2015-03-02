From: =?UTF-8?B?TWljaGFsIMWgbXVjcg==?= <msmucr@gmail.com>
Subject: Re: Kenrel panic with 3.18.7-rt2 - rootfs at MMC
Date: Mon, 02 Mar 2015 12:43:24 +0100
Message-ID: <54F44CDC.9070908@gmail.com>
References: <54EC487F.8020109@gmail.com> <CAP=VYLr=vMTRYCqoXcQBjrMT1-7dGp8fsThTYWzf=4L2tEYyyA@mail.gmail.com> <CAP=VYLqqDRfpz+LH21ZPQ3sVJ-Re4bUjWW9aRvzCB6=OCnQuWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44210 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbbCBLn0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2015 06:43:26 -0500
Received: by wiwl15 with SMTP id l15so14097409wiw.3
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2015 03:43:25 -0800 (PST)
In-Reply-To: <CAP=VYLqqDRfpz+LH21ZPQ3sVJ-Re4bUjWW9aRvzCB6=OCnQuWQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2.3.2015 2:31, Paul Gortmaker wrote:
>> Seems sdhci_irq is operating on a (non-raw) host->lock and you
>> are running that code in hard IRQ context, which will trigger the
>> alarm for operating on a sleeping lock while in atomic context.
>> (i.e code is not currently -rt friendly as-is).

>> In the future, putting the log lines in line (vs attachment) makes
>> it easier to reply and comment - meaning more people will look
>> at the report.

Paul,

thank you for comment and advice, I will post logs recommended way in 
the future.

Best regards,

Michal
