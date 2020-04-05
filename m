Return-Path: <SRS0=2W/x=5V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF7DC2BA1A
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Apr 2020 04:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F48206F5
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Apr 2020 04:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bw1OWVin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDEEyT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Apr 2020 00:54:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:41377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgDEEyT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Apr 2020 00:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586062425;
        bh=byFODQgrxw40xFre1c1817q+zVT7pD1Cw7ovMUR5hDA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=bw1OWVinuyeanFIn9lcdVwZO3hUoCh8lde93pZJKCDSyDHOlBXqcdyQUJLOCaAhu+
         jtVqkmk2sImqAnkGZV+3zDPiEon607no4ujJGJzmoTtCdl//YGdtI22qd+/gjCprFU
         Vl4NXADnap0EsLqOtJ5i+EjhKzJxWp3IwVMAnuBQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.81]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1jiY983nJG-00Njf1; Sun, 05
 Apr 2020 06:53:45 +0200
Message-ID: <1586062423.4816.15.camel@gmx.de>
Subject: 0087-rcu-Use-a-raw_spinlock_t-for-kfree-batching.patch
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 05 Apr 2020 06:53:43 +0200
In-Reply-To: <20200403170443.pzm24672qo4hufcm@linutronix.de>
References: <20200403170443.pzm24672qo4hufcm@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3f0yHEzIzs+KNoWjN5qVhmgJOiQ6U59pcTuCVUYmvSs1ZcaxzIE
 qaRdUN4KosfYoA3Z2BoBw2drzgAuMNfHCCX2B82xGa6GfAY58uZTwjFAUT4BRNPMErwPu8c
 AxhbWQryeOpT1C3MLdyQCf5lM2KIyDQTDQOTTiuNpgDPjeOj3hma3fC1DgDATw+MViZFUFo
 HRJKQ6mSlafnt/wBERsvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5SyYYjMWXZk=:Nvq2QZZGLHkIAXeR1oTYsY
 IfT4bW8Hzqg/nnD3Aceph02I4Qz8LyowhFPV9w+C8hOd8GHhUaN3tlFFG7N+1PkQCN/4CpR+W
 OHZ1/8twP0X0uS0DcaSGVoWKTSpx3egcO3jzAuMBG+enCw1/1Ir+r/QNYSo+7e2aWEPPNV1ah
 DVTz1wMOG6wvHCiLtNaID/pevHfGV4AgvvJV9uotDsshzqgSbxYOn1y2laUDnYBQKsQgFQVm2
 c44lFOQEvxfg9CcRu1UBywKBLlgVdoi9d0s3+eFs0uT282e9xmP1d3Qh7gdEjpa94k7C7SO49
 mCRJOQ5FntYkC52yWTZD1PHtJRA3FHEy89aJ8l7tsOnzAgIyx7EsMtHVSVUSstiLoqkqHevni
 LCauBgacrNN0IfugMbTmstztw8O80sFxjnSkUyj2ePm8mpOB6K/j4RVQgw7tJ0oEw5dEm512C
 L/1C7HXaKlIKAoIgY1tXXsxY/Y9ueFZHOzTywiNl2Q/nAGXYmSco5L3/dtmAishPo5nZ0dEnZ
 41iewRHJ9Bpw3Ndyau/ymit1FnrhNHF8FgKPYIEtfC0ln+VbgjotRbQN9o1F+5Qyv6s3FSNrv
 RCY2yDQyEP0UigbDs+BaNkcqQ6oJ0i5RvoDetSF/gQ0oF0kAh5N3ANZRdzPI2xUEquoNbkZTI
 YcTLx/8GddTilHvQ7so0k2rI6JRIEIA6I1/13rZu/2XkmJ5YRJzzMvY/6C9QCL5uC4rpPJ/kI
 2N8Kgt3SWb2oiTUCy7P5N/8tSzSEacnqJLUJKJxfEnjUPJjYBfF/fHb9dIaF+yuPvv89aloOy
 QcfhMzIHEODZK7HqL/wHWUB/oHG4nxp5A37EyZD6qtVLrqpeWJgcpGpQBfllvstOoJJq+2Q10
 YyH/seRZiJcO8k5VRVYPfXD/TiyY5DdUhCMPUWgYi9rdvuDLT3TWuZWIVCoCbp4G1rrjd+K4v
 Xytec3sNJMZPF2iV4Wbv7nT+xnsdBjUp+H3qdp5VmG+iNzgUz5Wx/OpLTYznA1nAcR3Te4NqL
 gsF7n2iDmMfOgu0ZPdLTQnFy9CJhncUYD8oNZymu01BHcca44afI9Wi9fw/v2UO1V0MmQjtIK
 z2sVof44V7H3yaF3t4dLf6vq2RFg0yZD7Q52OLXBSheMDVMwHLX70f2R03+0EHcxFp25ANnUd
 z/ZVMkMqcQQIdxn8UGQmrrmm62isbD/lBrUTo++Rt6VuACeP5RsenTgNOQlXO6zO7pkfn20wi
 z3fklczKWTbzdVAd1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

Just a heads up wrt $subject...

I had done the same in my 5.6 tree, but then 5.7 came along, and I had
to revisit due to 34c881745549e adding an allocation under that lock
with irqs disabled.  The same commit that added the lock added this.

	local_irq_save(flags);  // For safely calling this_cpu_ptr().

Whacking that instead of converting the lock cures 5.6 and 5.7 woes.

	-Mike
