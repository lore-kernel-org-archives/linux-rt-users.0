Return-Path: <SRS0=gXCI=C3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4088FC43464
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Sep 2020 15:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE902388B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Sep 2020 15:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjI078n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIRPSC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:18:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57977 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbgIRPSC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Sep 2020 11:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600442280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7mtqSUbu+54NUsHIS8lGB99Ry9oi3NNVPcFM9QRKAzs=;
        b=SjI078n/IqDL5+cFqX4gJk+6NkfSNLWHptYkzbcg6/EmfwA/AxBbBx+960M0faalrriheK
        +oqly7A+J/TRFG0jCAPm7oVkEvMNqup/qoe9gQfNevnhFEIHlk5w9SDCk769/PpHp31tPd
        PnG20nCg++b0M6ZCRV1p8WMEArLscQ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-wjCsJ3SPOe-7p9Zb5nnUJA-1; Fri, 18 Sep 2020 11:17:53 -0400
X-MC-Unique: wjCsJ3SPOe-7p9Zb5nnUJA-1
Received: by mail-ed1-f69.google.com with SMTP id c3so2424986edm.7
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Sep 2020 08:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7mtqSUbu+54NUsHIS8lGB99Ry9oi3NNVPcFM9QRKAzs=;
        b=uDLplE4f/eQEVirZf2Es9MfxLNf23bze1sfRubuWKq7ZeNEokknUa55HBRhUrNI/al
         0UNIFYyqozK/QxOHc/IK7nhti6A0clcPWl3w7g0DU1yXpVqav95BqZ+KozoitDkydBpK
         u5Q2nka8YjLSIrHgK2paQP2Lue9UIABKKv7y7/TUS+jIoISZSSmlf1Fchozx79WVLwkD
         DNzxtHzeUV7TnhgQyPXhIzKdyrXD2hBDr84U67nYvXD2XLZuoxR7HRaXQk4BPjctOpoH
         Khe4Z0ggcEOoOVrDDmTSK2ie4dES3Iu4fsTf+gNExGLPwkcOZYI84YzKGzL9MFNvB0yI
         o4oQ==
X-Gm-Message-State: AOAM53395uuVEyAttJB57pCwb6wyOT1gt1iU6K++8T8Li6B1GpM8Sl3+
        MQMRkbTegvYXHy2e9P9lrwfqvT9ACYBymPgGQUXpLhv905tZhSSs1VQ3aVoxIOpbJeZ7AvrdBRB
        Xd/gTEcCGiXVw3L708YLzpTsWcpE=
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr38585217ejf.368.1600442272167;
        Fri, 18 Sep 2020 08:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfo0YDjVjtJ+pQTj+NgRkk4cAjYvUb1VnxC1oLEltJgbwaBGHWJB8W7BEWojwanT3DME3z2A==
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr38585167ejf.368.1600442271911;
        Fri, 18 Sep 2020 08:17:51 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id f4sm2354993edm.76.2020.09.18.08.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 08:17:51 -0700 (PDT)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [ANNOUNCE][CFP] Real-Time Linux Mini-Summit 2020 - Virtual
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        bastian.germann@linutronix.de,
        Anna-Maria <anna-maria@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Mark Brown <broonie@sirena.org.uk>,
        Daniel Wagner <wagi@monom.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Julia Cartwright <julia@ni.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Tom Rix <trix@redhat.com>, Scott Wood <swood@redhat.com>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dario Faggioli <raistlin@linux.it>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Drew Fustini <drew@beagleboard.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Scott Wood <swood@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Message-ID: <2a4608f6-f2b1-efaf-3370-ffd7e62cdbbc@redhat.com>
Date:   Fri, 18 Sep 2020 17:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The Real-Time Mini-Summit is organized by the Linux Foundation Real-Time Linux
(RTL) collaborative project. The event is intended to gather developers and
users of Linux as a Real-Time Operating System. The main intent is to provide
room for discussion between developers, tooling experts, and users.

The mini-summit will take place alongside the Open Source Summit + Embedded
Linux Conference Europe 2020, virtually. The summit is planned last day of the
main conference, Friday, October 30th, 2020.

If you are interested to present, please submit a proposal [1] before September
30th, 2020, at 23:59 EST. Please provide a title, an abstract describing the
proposed talk, a short biography, and describe the targeted audience. Please
indicate the slot length you are aiming for: The format is a single track with
presentation slots of 15, 30 minutes long. Considering that the presentation
should leave a space for discussion.

We are welcoming presentations from both end-users and developers, on topics
covering, but not limited to:

 - Real-time Linux development
 - Real-time Linux evaluation
 - Real-time Linux use cases (Success and failures)
 - Real-time Linux tooling (tracing, configuration, …)

Those can cover recently available technologies, ongoing work, and new ideas.

Important Notes for Speakers:

All speakers are required to adhere to the Linux Foundation events’ Code of
Conduct. We also highly recommend that speakers take the Linux Foundation online
Inclusive Speaker Orientation Course. Avoid sales or marketing pitches and
discussing unlicensed or potentially closed-source technologies when preparing
your proposal; these talks are almost always rejected due to the fact that they
take away from the integrity of our events, and are rarely well-received by
conference attendees.

All accepted speakers are required to submit their slides prior to the event.

[1] Submission page: https://forms.gle/yQeqyrtJYezM5VRJA

Important Dates:

CFP Close: Saturday, September 30th, 2020, at 23:59 PST
Speaker notification: October 10th, 2020
Conference: Friday, October 30th, 2020

Questions on submitting a proposal?
Email Daniel Bristot de Oliveira <bristot@redhat.com>

