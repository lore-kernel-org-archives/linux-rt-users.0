Return-Path: <SRS0=K3q3=X5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E4AC47404
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 16:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5914920873
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Oct 2019 16:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzQxpEXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbfJDQUy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:20:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38620 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390152AbfJDQUy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Oct 2019 12:20:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so7118301ljj.5;
        Fri, 04 Oct 2019 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=esA6+awGjiFzCbqVXjFrVJ00nRBU2EYyMDWs4D5Bo9k=;
        b=jzQxpEXu981x/R4lBeyi37dR9lNATiNXvQIQcX78AibLePSTwnTPgExbDqvKaaQWLq
         LrdMMMlPpdr1jBSuzh+AirY9496WZnUkB9RFQVv/ZEo0d/FBrzRtGplxVVs/nH+Zdtht
         fNWc7yRznWVaRwrgsAcyyqtj9YUb45VG23pbp4+8okBiworkHUejExjulGgOTeP/eQx4
         isJnZMNNvHIriF+u5m1xgDYFE2EEG5/qLAug/AMUcMciutF5q4V4wLTwoYqRiWgw728p
         w421te/O6o8DZMGLkiEjt5iw/hjGex7J5N+AfTHMs0Az1CatAJc0KMiSeuqAtgxRH3P3
         xeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=esA6+awGjiFzCbqVXjFrVJ00nRBU2EYyMDWs4D5Bo9k=;
        b=mXBgJMhPwjvGZO6qHcX9MfvXeWiMbdbs6s0VEDvHG1LnswcyCpHgGgFlbaJZvTHdXA
         YbOip6wHfZhPGO0KpAHzK5asjewWlkLIZ1y+4964rSgZRDF1b4VibIunZSlHB8cixA50
         iNl2+NLFip+EueTR5/QV8TCwIhhGgWJGEos5mdv9mvZYOMj8qsY/TuL3hVIy58HeVR4y
         q2ayE3GcKNNuuB3EDS7kcKvc7rGLoczIxL3WWwTo0RfnTC/lFfHYNgXW/y8KzlrayK3Y
         vOdyd/jO/j5f+VTWGTw6HavaOCOur3/eexRrNB2GZ0L+oMDWvbO1cRebHO55ICzj66tJ
         +XIA==
X-Gm-Message-State: APjAAAVrc/UxinJhkBeENOsxI/ofn7/cLUNViQvl+RVCP9p0gfaTXWoS
        U1/kcMpP5otJS1vMM23I5qI=
X-Google-Smtp-Source: APXvYqx5KFDU3H6pNRjg1NQbE6teRhCUB8J57fMUlIj1AcLch3+TZ7ihEN7H5oa8mKxdRpgD6cquTw==
X-Received: by 2002:a2e:9d44:: with SMTP id y4mr10224990ljj.115.1570206050168;
        Fri, 04 Oct 2019 09:20:50 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id q19sm1341149ljj.73.2019.10.04.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:20:48 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 4 Oct 2019 18:20:41 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191004162041.GA30806@pc636>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Oct 04, 2019 at 05:37:28PM +0200, Sebastian Andrzej Siewior wrote:
> If you post something that is related to PREEMPT_RT please keep tglx and
> me in Cc.
> 
> On 2019-10-03 11:09:06 [+0200], Daniel Wagner wrote:
> > Replace preempt_enable() and preempt_disable() with the vmap_area_lock
> > spin_lock instead. Calling spin_lock() with preempt disabled is
> > illegal for -rt. Furthermore, enabling preemption inside the
> 
> Looking at it again, I have reasonable doubt that this
> preempt_disable() is needed.
> 
The intention was to preload a current CPU with one extra object in
non-atomic context, thus to use GFP_KERNEL permissive parameters. I.e.
that allows us to avoid any allocation(if we stay on the same CPU)
when we are in atomic context do splitting.

If we have migrate_disable/enable, then, i think preempt_enable/disable
should be replaced by it and not the way how it has been proposed
in the patch.

--
Vlad Rezki
