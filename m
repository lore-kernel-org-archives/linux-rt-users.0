From: Arve Barsnes <arve.barsnes@gmail.com>
Subject: Re: linux 3.9 rt patch
Date: Tue, 27 May 2014 21:09:40 +0200
Message-ID: <CAJjrzcVhhde3Ek57DM5e6oAbubPFeM7Ppvu4J9+C6banXs2GBw@mail.gmail.com>
References: <1401170492.8351.YahooMailNeo@web120104.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:48570 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaE0TKB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 May 2014 15:10:01 -0400
Received: by mail-yk0-f169.google.com with SMTP id 200so7556263ykr.28
        for <linux-rt-users@vger.kernel.org>; Tue, 27 May 2014 12:10:01 -0700 (PDT)
In-Reply-To: <1401170492.8351.YahooMailNeo@web120104.mail.ne1.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 27 May 2014 08:01, monmon icem <icy_monk@yahoo.com.au> wrote:
>
> Hi,
>
> sorry for the noob question. I'm little desperate, I'm looking for an RT  patch for  linux 3.9 kernel, I've noticed the patches are even numbered version only. Is there a patch for linux 3.9
>

Unless any developers have any personal 3.9-rt branch where they were
keeping up with the kernel until 3.10, I assume your best bet is to
pick up the 3.8.13.14-rt31 or 3.10.4-rt1 patches and manually go
through them until they apply to your kernel.
