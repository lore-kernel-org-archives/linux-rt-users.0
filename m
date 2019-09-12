Return-Path: <SRS0=iEIM=XH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9147AC4CEC6
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC1208C2
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Sep 2019 22:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aB6FI72F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfILWTo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:19:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33691 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfILWTn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id t11so12370758plo.0
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Sep 2019 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VYcaD0CgRaK6iDJ2VeDVxMN7Qlt4v9GgR7dsZ3QROoA=;
        b=aB6FI72FYFUB6TYj52LB9VxYzjcfuAlJ5r2flFNdTbRg4p1IaVUcTZm3lsv1Vk3MFj
         d3KPmw3cMHf2xPzsSICJHsynW5UpzDwugYamm6crgk2QXrW+TxfqcPLM4n6CjNHfUsp/
         gj7eIriG93QDFxaXCjJyW4Dc9tdfuI3kqStOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VYcaD0CgRaK6iDJ2VeDVxMN7Qlt4v9GgR7dsZ3QROoA=;
        b=M5rsaOMK9+cHEhAN8jiHy5Jtw2UfybYACVkzH0fUIpz/413IarQ5RSyqSQlqecerno
         ykgkX9YVrAhjSRjDJJa8nJIZ5V7DsKzyD7flanVoqYK7tU+q+M/8d7MTnhjBsU+swDA1
         OOkaXrbG3y/FTH+BjvK1EGFbu4NyD4nP6Wjqg6ttO4KepdywSPHosFvWp6/kpL82Jwpo
         8/YcmLyhcDx8DplZjKB3LKYG5JuZHFh383N0u2zcfUoYlWShyPeq/wIy2M30NWpImq1x
         PYUDtkMiWkRZEuBMiqUWgPj6KZDMgLCHf2ZYXfBwufFav70be7R4QThoAKUsoBHhgCcP
         6gHg==
X-Gm-Message-State: APjAAAXfhT6WwWQmpnesxWOpo3kBzznY0jcWzrR5PcvRi8ChQXrsllzC
        WQ5y0aU+V5kn/3yHcAziwI0VAg==
X-Google-Smtp-Source: APXvYqxEIAKiH7VoObg5pPCE1OSWvWVPGgLO5md2J4MB25LnCgnALkNSrNECU0GFs+pMubwA5uSWNg==
X-Received: by 2002:a17:902:8302:: with SMTP id bd2mr46615100plb.9.1568326782713;
        Thu, 12 Sep 2019 15:19:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 132sm1673199pgg.52.2019.09.12.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:42 -0700 (PDT)
Date:   Thu, 12 Sep 2019 18:19:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RT v3 4/5] rcu: Disable use_softirq on PREEMPT_RT
Message-ID: <20190912221941.GD150506@google.com>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-5-swood@redhat.com>
 <20190912213843.GA150506@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912213843.GA150506@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Sep 12, 2019 at 05:38:43PM -0400, Joel Fernandes wrote:
> Hi Scott,
> 
> Would you mind CC'ing rcu@vger.kernel.org on RCU related patches? I added it
> for this time.
> 
> On Wed, Sep 11, 2019 at 05:57:28PM +0100, Scott Wood wrote:
> > Besides restoring behavior that used to be default on RT, this avoids
> > a deadlock on scheduler locks:
[snip]
> > [  136.995194] 039:  May be due to missing lock nesting notation
> > 
> > [  137.001115] 039: 3 locks held by rcu_torture_rea/13474:
> > [  137.006341] 039:  #0:
> > [  137.008707] 039: 000000005f25146d
> > [  137.012024] 039:  (
> > [  137.014131] 039: &p->pi_lock
> > [  137.017015] 039: ){-...}
> > [  137.019558] 039: , at: try_to_wake_up+0x39/0x920
> > [  137.024175] 039:  #1:
> > [  137.026540] 039: 0000000011c8e51d
> > [  137.029859] 039:  (
> > [  137.031966] 039: &rq->lock
> > [  137.034679] 039: ){-...}
> > [  137.037217] 039: , at: try_to_wake_up+0x241/0x920
> > [  137.041924] 039:  #2:
> > [  137.044291] 039: 00000000098649b9
> > [  137.047610] 039:  (
> > [  137.049714] 039: rcu_read_lock
> > [  137.052774] 039: ){....}
> > [  137.055314] 039: , at: cpuacct_charge+0x33/0x1e0
> > [  137.059934] 039:
> > stack backtrace:
> > [  137.063425] 039: CPU: 39 PID: 13474 Comm: rcu_torture_rea Kdump: loaded Tainted: G            E     5.2.9-rt3.dbg+ #174
> > [  137.074197] 039: Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C620.86B.01.00.0763.022420181017 02/24/2018
> > [  137.084886] 039: Call Trace:
> > [  137.087773] 039:  <IRQ>
> > [  137.090226] 039:  dump_stack+0x5e/0x8b
> > [  137.093997] 039:  __lock_acquire+0x725/0x1100
> > [  137.098358] 039:  lock_acquire+0xc0/0x240
> > [  137.102374] 039:  ? try_to_wake_up+0x39/0x920
> > [  137.106737] 039:  _raw_spin_lock_irqsave+0x47/0x90
> > [  137.111534] 039:  ? try_to_wake_up+0x39/0x920
> > [  137.115910] 039:  try_to_wake_up+0x39/0x920
> > [  137.120098] 039:  rcu_read_unlock_special+0x65/0xb0
> > [  137.124977] 039:  __rcu_read_unlock+0x5d/0x70
> > [  137.129337] 039:  cpuacct_charge+0xd9/0x1e0
> > [  137.133522] 039:  ? cpuacct_charge+0x33/0x1e0
> > [  137.137880] 039:  update_curr+0x14b/0x420
> > [  137.141894] 039:  enqueue_entity+0x42/0x370
> > [  137.146080] 039:  enqueue_task_fair+0xa9/0x490
> > [  137.150528] 039:  activate_task+0x5a/0xf0
> > [  137.154539] 039:  ttwu_do_activate+0x4e/0x90
> > [  137.158813] 039:  try_to_wake_up+0x277/0x920
> > [  137.163086] 039:  irq_exit+0xb6/0xf0
[snip]
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> > The prohibition on use_softirq should be able to be dropped once RT gets
> > the latest RCU code, but the question of what use_softirq should default
> > to on PREEMPT_RT remains.
> > 
> > v3: Use IS_ENABLED
> 
> Out of curiosity, does PREEMPT_RT use the NOCB callback offloading? If no,
> should it use it? IIUC, that does make the work the softirq have to do less
> work since the callbacks are executed in threaded context.
> 
> If yes, can RT tolerate use_softirq=false and what could a realistic softirq

s/use_softirq=false/use_softirq=true/

thanks,

 - Joel

