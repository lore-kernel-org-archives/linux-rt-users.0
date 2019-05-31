Return-Path: <SRS0=n5VO=T7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA22C04AB6
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABFF26C9F
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 16:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEaQ47 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 May 2019 12:56:59 -0400
Received: from mr012msr.fastwebnet.it ([85.18.95.70]:40614 "EHLO
        mr012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaQ47 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 May 2019 12:56:59 -0400
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhtefuvfghgfeupdcuqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthejredttdefjeenucfhrhhomhepifhiuhhlihgrnhhoucevohhllhgruceoghhiuhhlihgrnhhordgtohhllhgrsehfrghsthifvggsnhgvthdrihhtqeenucfkphepudehuddrtddrudeluddrudegudenucfrrghrrghmpehhvghlohepmhhitghrohhsvghrvhgvrhdrlhhotggrlhguohhmrghinhdpihhnvghtpeduhedurddtrdduledurddugedupdhmrghilhhfrhhomhepoehgihhulhhirghnohdrtgholhhlrgesfhgrshhtfigvsghnvghtrdhithequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhrthdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsrghntggvlhhothesnhhumhgrlhhlihgrnhgtvgdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from microserver.localdomain (151.0.191.141) by mr012msr.fastwebnet.it (5.8.208) (authenticated as giuliano.colla)
        id 5CB685A202173852; Fri, 31 May 2019 18:56:56 +0200
Subject: Re: intel j1900 and i915 realtime problems
From:   Giuliano Colla <giuliano.colla@fastwebnet.it>
To:     =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
References: <bf7df0b0-64b4-910f-137e-1eba406d3f52@numalliance.com>
 <e8b5ac8d-2ff1-791f-98da-4f4854676873@fastwebnet.it>
Message-ID: <c683aad3-720e-1181-ea95-703709a9e258@fastwebnet.it>
Date:   Fri, 31 May 2019 18:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e8b5ac8d-2ff1-791f-98da-4f4854676873@fastwebnet.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sorry guys for having posted again. It's an hiccup of my mail client!

-- 
Do not do to others as you would have them do to you.They might have different tastes.

