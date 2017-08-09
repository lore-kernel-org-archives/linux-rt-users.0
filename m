From: Journey Journey <journeywang123@gmail.com>
Subject: Kdump not working with rt patch, tested under 4.4.32/4.4.79/4.9.40
Date: Wed, 9 Aug 2017 17:05:42 +0800
Message-ID: <CAF6bL9=e4Ah6iwmvj+PponVgYaSGKYJ1WW98sZgvAY9cK8_9Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:37891 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdHIJFn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2017 05:05:43 -0400
Received: by mail-pg0-f54.google.com with SMTP id l64so25528129pge.5
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Aug 2017 02:05:43 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Test case: https://github.com/saiyamd/softlockup_test/blob/master/softlockup_test.c
