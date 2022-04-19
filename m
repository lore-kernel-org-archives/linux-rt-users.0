Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A516C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 07:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349412AbiDSHdg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 03:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349427AbiDSHd3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 03:33:29 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E48A1AD8D
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 00:30:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 829065D659;
        Tue, 19 Apr 2022 09:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1650353442; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language;
        bh=IHswdYgfy4otijIS5notaV7adjGbotu7B3bN1x2qvuU=;
        b=lYssJVDdOVfVkUkSae2xfhHmYrt4UkwHaNSON30HEBgo4/LZ2QDPQnVCS7yLh4VUINTqmB
        4ZWr57lGFio+sFa/DWR7OYFajJezovlcdbdOhxsD/iSPX3rwQ1RCl5awGVGraNHeeI3MYV
        dP7WF4SplEEvFypMgHvYBLg9OcsoxEE0G/qIQi7M0GxWcX300OTlkOan+h26gppDc9dlm9
        wJRn738jR5lDZFtHGtBuYnst4CAakOlZH/ciZdgvhgPfpmHFOWRoNvb4X6sEB4lk3lrZ6L
        MFF5rI6QEykX9UH7ONJIcFTDF36DHGVxyCc/Fd7ZXdn70QepO30HX31iwUG8Kg==
Message-ID: <5c1e1916-6966-f54c-6af5-ad06ac945718@monom.org>
Date:   Tue, 19 Apr 2022 09:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org, xenomai@xenomai.org
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] High altitude realtime workshop 2022 edition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

What: High altitude realtime workshop 2022 edition
When: 2020-06-05 to 2020.06.07
Where: Glungezer lodge (near Innsbruck, Austria)


We discuss hot topics, current problems and how to solve them. All this
in a relaxed setting with spectacular views in the Austrian alps.

Note: To reach the location a 2 hours alpine hike is necessary. There is
no other means to reach the lodge. Furthermore, the location is very
small which means the number of attendees is very limited. In the last
years turn up was around 10 to 12 attendees.


- FORMAT

The summit is organized to cover 2 days of discussion and talks.


- ATTENDING

Attending the Summit on a Summit is free of charge.

Please drop a mail to the organizer to register.

While it is not strictly required to submit a topic/presentation (see
below), registrations with a topic/presentation proposal will take
precedence.

There is no registration or conference fee. Though you have to
pay for the lodge and the food/drinks you consume. From past
experience this is around 200 Euros for the whole event.


- VENUE

Since the lodge is a few hours by foot from civilization, staying at the
lodge strongly recommended. You don't have to do an reservation for
yourself. We have a block reservation for the large single sleeping
room. You will be sharing a single room when sleeping, so bring your ear
plugs with you. It also a good idea to bring your own sleeping bag.

Yes there is power available and we will have an Internet uplink. It
will not be fast, but checking for some emails it be okay but not for
streaming videos.

You should have a pair of good hiking shoes (This is really important!).
It is not a difficult path just in case the weather is nasty. Also a
rain jacket is highly recommended to bring with you.

A hiking backpack should be enough to bring clothes and other equipment
with you for 3 days.

Food and drinks are available at the lodge. The hike to the lodge is
around 2 hours (7 km). So it is not particular long but you might want
to bring some water or food with you.


- ORGANIZERS (in alphabetical order)

Christoph Hellwig
Daniel Wagner
Richard Weinberger
