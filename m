Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB6C433E6
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E764E3E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhBRP4v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:56:51 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:50963 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230074AbhBROul (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 09:50:41 -0500
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id CkaDlOJJw5126CkaElmWFj; Thu, 18 Feb 2021 15:47:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1613659631; bh=ob5nB1Gnrx5P2p/SsJpYVYnPyu7QJYTf5zK6EWEay8o=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=tc7Iomi1IkcgTBUCz3JsKAJequzWSowmVyDYTMJs4tm6ggloZLzAZIXGixJ43bc9V
         dm2WCEiHzEI4FQgBDbaq9K7VLj2mOrCrnd1AcNpPTe9gel5uVCoyrxy5nNOjCBJMKF
         io0SitH+ZO6dGQ64wqiMDKVI6NJeeSFiFs4HLtWWot3Cg3d4s9idXo4sFtoyjBYI75
         N4QqA8NvwAAoSk4dGoxnYEuEZdVyREO3yYlvjzU3Y8kBByUrCgwrTXJOWZp5wSJtqH
         AVQRaRB2uFcCde2UZxfDPrN9F7oHofpyQpyH0zkzWL7nUdWhFKXAfvGDlRB1q4RR6U
         bvoBIXJMvSNiQ==
Subject: Re: rcu_preempt detected stalls [5.9.1-rt]
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
References: <47623850-fb85-aac0-9d44-85d7914a321f@xs4all.nl>
 <20210218144104.rfpcpzp6rhvks5vj@linutronix.de>
 <20210218144334.fnohryfmztsywxly@linutronix.de>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Organization: hierzo
Message-ID: <a625ec08-730b-d09e-28f4-ba11febe6493@xs4all.nl>
Date:   Thu, 18 Feb 2021 15:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218144334.fnohryfmztsywxly@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBg9rDqpbQaMNCk5rnt0nsLn760a03xNF/lNopJFbJLkuWKP+4Ok9NtrnwHq1ItSnnqnT0gwSUfzI9463+jqvVt062Duteij575tK0MRwaEJHPdoev6h
 qfXw0x/i2zrmi4rokjvBbBL4da0MInJbjDkX6grs9Um5zPZZQ/+12lPQMzlRTP33kfXDffBfGK8z3DaI6CkuKkzEt7tznsVpzZGxjcnlUOlhxOL04CJCIwMp
 I9Rz4yL2u/TNb1wKWjnomsmmiI0E8GEtV16BMM/3woEqo947efUxAY3onxtzHk75
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 18-02-2021 15:43, Sebastian Andrzej Siewior wrote:
> I just remembered that you had a box named vuurmuur running ntpsec.
> There was something I didn't fully debug but I had some hints where to
> look. Any chance that box has also ntpsec running?

100% yes.

Udo

