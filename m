Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16740C282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E882720678
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 17:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgAJRgx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:36:53 -0500
Received: from mail.softplc.com ([206.126.248.66]:64379 "EHLO mail.softplc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbgAJRgx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 12:36:53 -0500
Received: from [192.100.100.3] ([::ffff:107.174.231.239])
  (AUTH: PLAIN dick@softplc.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.softplc.com with ESMTPSA; Fri, 10 Jan 2020 12:36:51 -0500
  id 00000000001E0003.000000005E18B633.0000514F
Subject: Re: [PATCH RT 0/2] serial: 8250: atomic console fixups
To:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
References: <20200110153932.14970-1-john.ogness@linutronix.de>
From:   Dick Hollenbeck <dick@softplc.com>
Message-ID: <ddecdfb7-907e-7198-1c82-efb044c080de@softplc.com>
Date:   Fri, 10 Jan 2020 11:36:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110153932.14970-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 1/10/20 9:39 AM, John Ogness wrote:
> Dick Hollenbeck pointed out[0] that serial usage for non-consoles
> was dramatically affected due to the atomic console
> implementation. Indeed, the implementation was taking the global
> console_atomic_lock for _all_ 8250 ports, regardless if they were
> consoles or not.
>
> This series fixes that by only using the cpu-lock if the port is
> a console. While making those changes, I realized that the clear
> counter/ier-cache is not needed, so that is also removed.
>
> Dick also pointed out that the IER accessor functions were using
> non-typical names. These are updated and moved to inline macros.
>
> Finally, I noticed that the fsl, ingenic, and mtk variants were
> directly accessing IER. These are now also appropriately wrapped.
>
> In his suggestion, Dick did optimizations regarding IER caching.
> However, these are _not_ included because they may have some
> unwanted side-effects. For example, 




> I noticed a few places in
> 8250 code where the value of uart_8250_port->ier is expected to
> be different than the hardware register.

Sure, its not a trivial change, but I still think it would be superior to try and get it
right.  But I certainly have no more influence than the prior sentence.

I see this as unfortunate, and a propagation of a weak original design which stems from a
time when inline C functions were not even available.

  If serial8250_set_IER() function returned the prior value, it could be saved on the stack and still be an indication of difference from the current hardware for the temporary situation at hand.

Then, the compiler would have had a better chance of optimizing out the return value when it is not needed, because it would be a mere reading of the prior value from the struct.

I know I expressed some concern about using *3* functions, set, clear, and restore before, when 2 might suffice.  However we've seen other situations where a clear and restore are used, such as interrupt flags.
( "set" is a mere lower level common gateway to the hardware in our context.)  So down the road, a clear() and restore() may give you the option to do some locking and unlocking, which I know you don't currently think you need.  Pardon me for un-weighting my concern for 3 functions.

It is certainly a major improvement.  To be honest, I will probably simply comment out the console support in the inline function when and if I ever upgrade my code. I like that its inline, and that its in a single function.

Dick







