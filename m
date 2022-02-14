Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A104AC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Feb 2022 18:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiBNSkA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:40:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiBNSj7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Feb 2022 13:39:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEEF654B4;
        Mon, 14 Feb 2022 10:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE1260EAD;
        Mon, 14 Feb 2022 18:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB04C340E9;
        Mon, 14 Feb 2022 18:39:47 +0000 (UTC)
Date:   Mon, 14 Feb 2022 13:39:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Message-ID: <20220214133945.11119c2a@gandalf.local.home>
In-Reply-To: <8f034cd5-8495-de0e-6a3c-4d002e49cc51@linuxfoundation.org>
References: <20220214083657.165921-1-krzysztof.kozlowski@canonical.com>
        <Ygo6pqWmkTWJNNcR@linutronix.de>
        <8f034cd5-8495-de0e-6a3c-4d002e49cc51@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 14 Feb 2022 11:33:18 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Steve,
> 
> Would you like me to take this through linux-kselftest next for 5.18-rc1
> 
> I am guessing there is no urgency on this - of not I can take this in for
> rc5.

Hi Shuah,

Feel free to take it through your tree in any urgent level you like.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
