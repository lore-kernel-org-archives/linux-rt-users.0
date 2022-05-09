Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2172EC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 May 2022 10:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiEIKMx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 May 2022 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiEIKMu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 May 2022 06:12:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC9222387A;
        Mon,  9 May 2022 03:08:48 -0700 (PDT)
Date:   Mon, 9 May 2022 12:06:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652090792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRM2zMJ9XhBQmwQro9AS/tz3rra0CYimJ07/gdih+4g=;
        b=wQI5dVEpzI2jTq6PNAJStI8X544Ms++lTQPW8/tmEYTDnbG1+ihgP0hGW/i07N5hghWmS6
        PlyJUlyZqGAULc+FxtPTCVXyDB+rlJtld4gWUwB/RVgF4So5Vm8O409iJLZu+ML5yTqk0U
        oyqI3PblyXKABjqvM5JBm+eQl6cR5tLGGXvV6QkqxQ/geBVtaavESuxVRrfimWTDoE7MX7
        nqgqimmHc3yeoubqDITq3gzCXHlqYE9AXpyBuAsAk4lL0SA4T4GXVW33qdGXLQLQQr6Ohm
        uBe5TBTt5c/Q0Ai6BFXYqXKQdAI+l8Et+Ym9BGekwcTAxYForHcvSI9UaCUYXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652090792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRM2zMJ9XhBQmwQro9AS/tz3rra0CYimJ07/gdih+4g=;
        b=V8rd+T8MGrRH607niUq0b6Ovku6MsABSNAmj15ZPOth+ECLVvXwnSpAyq+Ot6Lc1V/Ya+6
        TpqbSp/WBjHJKICg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.18-rc5-rt5
Message-ID: <YnjnprZzEZUM4z89@linutronix.de>
References: <YnVagPnKc+SDnkP/@linutronix.de>
 <CAFTL4hxoGnTkXs4O4_L2bZafFjFJOPUH+U+h__zsfYOhLpsSGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFTL4hxoGnTkXs4O4_L2bZafFjFJOPUH+U+h__zsfYOhLpsSGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-05-09 12:04:21 [+0200], Frederic Weisbecker wrote:
> Please don't ignore
> https://lore.kernel.org/all/20220405010752.1347437-1-frederic@kernel.org/
> and https://lore.kernel.org/all/20220405010752.1347437-2-frederic@kernel.org/
> 
> Especially the second patch fixes a pretty serious issue!

Sorry, this somehow slipped.

> Thanks.

Sebastian
