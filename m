From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Kdump not working with rt patch, tested under
 4.4.32/4.4.79/4.9.40
Date: Wed, 9 Aug 2017 07:45:54 -0500
Message-ID: <3e184524-0392-06a7-e929-abcd85517cfe@mvista.com>
References: <CAF6bL9=e4Ah6iwmvj+PponVgYaSGKYJ1WW98sZgvAY9cK8_9Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Journey Journey <journeywang123@gmail.com>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36723 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdHIMp5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2017 08:45:57 -0400
Received: by mail-pf0-f182.google.com with SMTP id c28so27488939pfe.3
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Aug 2017 05:45:57 -0700 (PDT)
In-Reply-To: <CAF6bL9=e4Ah6iwmvj+PponVgYaSGKYJ1WW98sZgvAY9cK8_9Eg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/09/2017 04:05 AM, Journey Journey wrote:
> Test case: https://github.com/saiyamd/softlockup_test/blob/master/softlockup_test.c

It works fine for us on all our architectures and platforms.

Maybe you should post some details, like what exactly happens, 
tracebacks if any,
what hardware you are running on, etc.

-corey
