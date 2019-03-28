Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDACCC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D8E217D7
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 12:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfC1MKp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:10:45 -0400
Received: from mail.manjaro.org ([176.9.38.148]:55008 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfC1MKp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 08:10:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 3F75230F39D8;
        Thu, 28 Mar 2019 13:10:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b3xGNCDw4HkD; Thu, 28 Mar 2019 13:10:41 +0100 (CET)
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux>
 <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
 <20190328120022.bhwijbp2roizysiw@linutronix.de>
From:   Bernhard Landauer <bernhard@manjaro.org>
Message-ID: <456872db-42f9-0c3c-ae91-ccc21f8563be@manjaro.org>
Date:   Thu, 28 Mar 2019 13:10:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190328120022.bhwijbp2roizysiw@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> "You need to sign in or sign up before continuing."

meh... sorry!

PKGBUILD:
https://pastebin.com/1N39b4E0

config:
https://pastebin.com/uE4xqyj1

