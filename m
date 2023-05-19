Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992BC77B7A
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjESSwp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESSwo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 14:52:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91094E43
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 11:52:43 -0700 (PDT)
Date:   Fri, 19 May 2023 20:52:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684522362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJrvlT33NTp60xT4pkD3xDWmHOwuREaLbgQbXDGTVfc=;
        b=Uu0uAZW3Jdkp3BzenurC4UlXaNygjAvUZcVwO45QKvLU49a/Z/Dc6p6k0g+3tX947GfiQK
        oiRRSo5J+h6OdSZDQDl4CoQrqgtHw/PLFbk0JjEHIBVN4WpDkJygG5jRpOQM73WMl3R3Sx
        5r/rj8QOapqT9NYvUlS4YKOUFaxxa65A6SW3solrz6xMhCgCTr7ugcXEUcQN09LKVMDbdi
        t5+Y6Y7Jq/5PQbE41OSKuKobXzwSmc3J6R7RwatpRqlgASuSS9Qn/PsqvgJt7xlrn+NfCk
        4R6mUwbozueZS0tCYXopkXV8s8x4Qy/JaoI+2R9c6AE86PRpnBJu8XS+VUbQTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684522362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJrvlT33NTp60xT4pkD3xDWmHOwuREaLbgQbXDGTVfc=;
        b=a2A3MxhqUk5eE+ZnLm/JfiSStgTnLkJcdFUkcMulQY5exCxdqZm5QNCwdlLTm2J0jxFgop
        0ngoz493pGTMAlAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
Message-ID: <20230519185241.03nTY1UE@linutronix.de>
References: <202305142217.46875.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202305142217.46875.pisa@cmp.felk.cvut.cz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-14 22:17:46 [+0200], Pavel Pisa wrote:
> Dear PREEMPT RT Linux kernel maintainers,
> 
> we have started to experience failures of PREEMPT RT kernels builds from
> 6.3 RC versions. We use kernel on MZ_APO educational kits
> based on MicroZed, Xilinx Zynq 7Z010 SoC. More about actual HW

I just released v6.3.3-rt15. Could you please give it a try and report
back if all problems are gone or not? Based on the backtrace I can't
tell if the other problems are follow-up or other things. 

Sebastian
