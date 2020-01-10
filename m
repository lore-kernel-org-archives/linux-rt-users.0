Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E828C282DD
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 14:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21372072E
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 14:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgAJOnV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:43:21 -0500
Received: from mail.softplc.com ([206.126.248.66]:50097 "EHLO mail.softplc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbgAJOnV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 09:43:21 -0500
Received: from [192.100.100.3] ([::ffff:107.174.231.239])
  (AUTH: PLAIN dick@softplc.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.softplc.com with ESMTPSA; Fri, 10 Jan 2020 09:43:19 -0500
  id 00000000001E0005.000000005E188D87.00002860
Subject: Re: 8250: set_ier(), clear_ier() and the concept of atomic console
 writes
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <6e0f459a-d3dc-73cb-679f-6e86008048e1@softplc.com>
 <87woarjucv.fsf@linutronix.de>
 <58f88e2b-de16-0c0a-b863-521b13ae45de@softplc.com>
 <87blrcerto.fsf@linutronix.de>
From:   Dick Hollenbeck <dick@softplc.com>
Message-ID: <62b9b75c-a245-a643-b715-27947f2ff994@softplc.com>
Date:   Fri, 10 Jan 2020 08:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87blrcerto.fsf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

Working with you has been significantly easier than working with other kernel developers,
and I attribute that to your good character.

I managed to get a patch into the 8250 mainline code about 13 years ago, generally it was
not easy, nor should it be.

I do believe that if your patch (yes now yours) is based on the inline function, and that
function does the struct field manipulation, that the 8250 code becomes much cleaner. This
is independent of console requirements.  Maybe that will helplful in moving the mountain
of old crufty serial code in mainline, and maybe you get a merge.  We can only hope.

Having some hours of usage on the patch in the RT space will also help.

I wish I had more time to help get the two trees merged, but I think you could be on the
right track now WRT 8250 serial, and I think your company has more standing in the kernel
community than mine.

Good luck,

Dick


On 1/9/20 6:29 AM, John Ogness wrote:
> After spending time working with and completing your patch, I realized
> that the 8250 atomic console implementation does not need to be so
> complex. Only serial8250_console_write_atomic() needs to track if it
> needs to re-enable IER. Everything else can be as in mainline.
> 
> I will post a patch that reverts the unneeded complexity, which will
> solve your problem.
> 
> Creating a macro for clearing IER is probably a good idea anyway to
> eliminate all the capabilities-checking redundancy. But I'll leave that
> as an excercise for mainline.
> 
> Your patch helped me to realize the insanity in what I was doing. Thank
> you.
> 
> John Ogness

