From: Daniel Wagner <wagi@monom.org>
Subject: Some benchmark results
Date: Mon, 25 Aug 2014 11:02:32 +0200
Message-ID: <53FAFBA8.3050009@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:50519 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbaHYJCf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 05:02:35 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so2190780wiv.7
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 02:02:34 -0700 (PDT)
Received: from handman.bmw-carit.intra (mail.bmw-carit.de. [62.245.222.98])
        by mx.google.com with ESMTPSA id d2sm29625551wiy.13.2014.08.25.02.02.33
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Aug 2014 02:02:33 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I wanted to know how good or bad mainline vs RT is, therefore I let
MMTests torture my laptop for a while. I selected a few of the supported
benchmarks by MMTests in order to keep to a reasonable time frame.

The aim was to see the impact of normal (no RT) workloads with different
preempt configurations on mainline and RT patched kernel. I tried to not
to change other configuration flags except the preempt one. There are
some small difference due to dependencies but the rest looks ok to me.

http://www.monom.org/rt/mmtests/

Suggestion, improvements, comments?

cheers,
daniel

