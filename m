Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D54BC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Mar 2021 16:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4182619BA
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Mar 2021 16:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhCWQv3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhCWQvH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Mar 2021 12:51:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF05C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Mar 2021 09:51:06 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c6so15419465qtc.1
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Mar 2021 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=LJasPMIhcysRCEMMgNJQkDcku4Duj54S4sBhlCzdSug=;
        b=lY9SQWjAzteOQ885Ix1MNgehxWK2JnyDacuIMtm0bDXSGl40sLbtd0tW8WNHzBKwhu
         G81Ekh43xsZQGIdQp6f/EE/G1nrgjsxtwSsyhBxjkkxjM+xuRSqV87EVaLUXjrL8kgel
         F2Fy2SOKJ2LOm/HbODYuleoQOIVzZnOtY1v3+ySBZNEs6Yfsr+fCl9IvzCdiysGcL5VQ
         HGipJYcEw3e05LGYKvjl9QV4Uz8fUDL6ICMHIQ8SlyVUawahgQFyhOOkcuPbyRrdlvoi
         mC3fUrLS71IO23/puXeO4WSErVa5gAbZ1qwTLO49GEY8lZfPJmiDzSUZS61bouV5B8AJ
         s5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=LJasPMIhcysRCEMMgNJQkDcku4Duj54S4sBhlCzdSug=;
        b=asxMC6eVouXs61RLO/EmXYgYzV8gNvl9YkQ9Ur76SKAAzygK1NcXJ6J36bzZG6JYW7
         EM/bObRzxbYcEaDlzW7FCiVeBq9CzGohMta+/XtHEXiVlto72d97o7rTyWMYsCrIqZTF
         WSwzubsqVVLcffA2XJSGuXAZldhFctgttEf4MHvQOyJlZvytKMhyBv665IyJojYEjAWV
         Fw8/BDm+M7D6Ho6ZrtVobmCEHilpFX7gtHEatWpyJn3BHL8mSEfSFajjNytWAkptcJM+
         gsKutWFcwXRJPLVxwUujquunU7V2EXFj7AcdFc+S8ygaO732NQgoDkrNH8IeYQN8Z6Gf
         /evg==
X-Gm-Message-State: AOAM533WRwDOPKvlWHNHUorUq4nIYMT5ozdHYlAJTITyW6BOq4yr1H2k
        RFNbFlL3Qh+HGvcBKV2AUU4=
X-Google-Smtp-Source: ABdhPJw3BqzLiC5Q+ugb0PUFcSD48scBxxhxt8iFoUCF94n+ZhB5XZBxxdAPehTxTzhga9/pbFmxgg==
X-Received: by 2002:ac8:5c82:: with SMTP id r2mr5194993qta.201.1616518266197;
        Tue, 23 Mar 2021 09:51:06 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id x21sm10270846qkj.25.2021.03.23.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:51:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 23 Mar 2021 12:51:04 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: rt-tests: cyclictest: Add option to specify main pid affinity
In-Reply-To: <dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com>
Message-ID: <60489dd5-15d0-5bbb-2cf4-ec2de33af460@redhat.com>
References: <20210222152833.8758-1-schwenderjonathan@gmail.com> <YDPZ0xrEcsS5SfWh@lx-t490> <dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463809278-1928658612-1616518265=:8289"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809278-1928658612-1616518265=:8289
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 21 Mar 2021, Jonathan Schwender wrote:

> 
> On 2/22/21 5:20 PM, Ahmed S. Darwish wrote:
> > On Mon, Feb 22, 2021 at 04:28:30PM +0100, Jonathan Schwender wrote:
> >> Hi John,
> >>
> >> This patch adds the option --mainaffinity to specify the affinity of
> >> the main pid.
> >> This is mainly useful if you want to bind the main thread to a
> >> different (e.g. housekeeping ) CPU than the measurement threads.
> >>
> > Do you also have any numbers showing different results with/without
> > "--mainaffinity"?
> 
> Sorry for the delay. I do have some numbers now, and there is a benefit to
> using this option if CPU isolation + CAT are used. Otherwise it's not really
> visible.
> 
> Rendered Markdown:
> https://gist.github.com/jschwe/d4c46026aec57b10a2b0e6f72258b96e
> 
> # Testing proposed cyclictest --mainaffinity option
> 
> System information:
> - 2 socket Intel Xeon E5-2643 v4 @ 3.40Ghz
> - Turbo boost is disabled.
> - Fedora 33 with kernel 5.10.1-rt20 with small patch (see cmdline isolcpus)
> - Cmdline: `nosmt isolcpus=domain,managed_irq,wq,rcu,misc,kthread,3,5,7,9,11
> rcu_nocbs=3,5,7,9,11 irqaffinity=0,2,4 maxcpus=12 rcu_nocb_poll nowatchdog
> tsc=nowatchdog processor.max_cstate=1 intel_idle.max_cstate=0
> systemd.unified_cgroup_hierarchy=0`
>     - The additional isolcpus arguments set the HK_FLAG with the corresponding
>     name.
>       This cmdline adds all HK_FLAGs usually set by nohz_full, except the
>       actual
>       nohz flags `tick` and `timer`. This improves cyclictest latencies on my
>       system.
> - Rteval is running on all CPUs from node 0 + CPU 1, but not on the isolated
> CPUs.
> - L3 Cache is reserved for the isolated CPUs via `resctrl` (CPU based
> allocation)
> - Test duration 24 hours, interval 200 µs
> 
> 
> ## Test 1: 5 cyclictest instance with main pid on same cpu as the measurement
> thread
> 
> This test simply starts 5 cyclictest instances (via numactl) with one
> measurement thread each and bound to a single
> CPU via `--affinity`, so that the main thread is also bound to the same CPU.
> 
> ![Figure: 5 cyclictest instances with main pid pinned to same CPU as
> measurement
> thread](https://gist.githubusercontent.com/jschwe/d4c46026aec57b10a2b0e6f72258b96e/raw/e27c3f284cf4bbeecded84865dfee5676b47fe88/2021-03-11.png)
> 
> ## Test 2: Single cyclictest instance with --mainaffinity=1 for isolated CPUs
> 3,5,7,9,11
> The main thread was placed on CPU 1 via `--mainaffinity` and
> `--refresh_on_max` was added for good measure to keep the
> logfile small.
> 
> ![Figure: Single cyclictest instance with --mainaffinity=1 for isolated CPUs
> 3,5,7,9,11](https://gist.githubusercontent.com/jschwe/d4c46026aec57b10a2b0e6f72258b96e/raw/afd81b2a70a3e88bdebc46615d0f60e24238b405/2021-03-19.png)
> 
> >
> > Thanks,
> >
> > --
> > Ahmed S. Darwish
> Jonathan
> 
> 

Alright, I can imagine how this could be useful. Would you respin the 
patches against the latest upstream and resend to me?

Thanks

John
---1463809278-1928658612-1616518265=:8289--
