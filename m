Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF078C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 18:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9518060FBF
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 18:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhJDSE2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:04:28 -0400
Received: from goliath.siemens.de ([192.35.17.28]:47894 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhJDSE0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 14:04:26 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 14:04:25 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 194Hscum011560
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rt-users@vger.kernel.org>; Mon, 4 Oct 2021 19:54:38 +0200
Received: from [167.87.3.213] ([167.87.3.213])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194Hsbqv000302
        for <linux-rt-users@vger.kernel.org>; Mon, 4 Oct 2021 19:54:37 +0200
To:     RT <linux-rt-users@vger.kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: arm64: kvm + RT
Message-ID: <c640276e-77ca-f895-715e-053bae754f89@siemens.com>
Date:   Mon, 4 Oct 2021 19:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

what's the state of getting kvm working (again?) along RT? Seems
HAVE_POSIX_CPU_TIMERS_TASK_WORK is in conflict with KVM but a
precondition for RT on recent kernels. What's the story behind that?

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
