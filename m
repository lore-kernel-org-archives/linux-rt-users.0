Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lf0-f45.google.com ([209.85.215.45]:43417 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeFDU4X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jun 2018 16:56:23 -0400
Received: by mail-lf0-f45.google.com with SMTP id n15-v6so77957lfn.10
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jun 2018 13:56:23 -0700 (PDT)
Date: Mon, 4 Jun 2018 22:56:19 +0200
From: Henrik Austad <henrik@austad.us>
Subject: Re: printf & writing to disk
Message-ID: <20180604205619.GA20752@sisyphus.home.austad.us>
References: <CAJ2oMhJ3koLBA3=d0y+UBh2n1JH442vVLbFUxppSjFYN8wXLNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJ3koLBA3=d0y+UBh2n1JH442vVLbFUxppSjFYN8wXLNg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On Sun, Jun 03, 2018 at 09:43:32PM +0300, Ran Shalit wrote:
> Hello,

Hi Ran,
 
> How should printf and write to disk should be handled in rt application ?
> 
> 1. printf - can it be used in rt application ? how ?
> 
> 2. writing to file in disk - should it be done in separate thread with
> lower priority ? or doesn't it make any difference in which thread ?

So, typical usecase for writing to disk from an RT app would be logging, 
something most applications need to do at one stage or another.

You do *not* want to write to do any blocking calls directly from an RT 
thread! At least not any calls that may block outside of your control (like 
locks). Writing to file is typically one such thing, allocating memory 
another.

If you need to write to disk, I *strongly* suggest you implement some sort 
of asynchronous setup (writing to a ringbuffer, message-passing with 
pre-allocated buffers, or some other scheme) and let a different thread 
handle the actual writing.

The same goes for memory, do try to allocate all memory that the RT 
thread(s) will use at the beginning and avoid all calls to malloc during 
run-time (this is where C++ can be interesting, so be careful!)

Good luck!

-- 
Henrik Austad
