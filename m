From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: Re: Intel real-time Linux production kernel
Date: Tue, 6 Jun 2017 09:19:42 +0200
Message-ID: <7414773e-5610-94f6-9278-687956f3727e@numalliance.com>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D673203@ORSMSX101.amr.corp.intel.com>
 <20170602185015.GB31147@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Sapra, Rajesh" <rajesh.sapra@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Hindman, Gavin" <gavin.hindman@intel.com>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.numalliance.com ([83.206.84.204]:36564 "EHLO
        mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdFFHUP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Jun 2017 03:20:15 -0400
In-Reply-To: <20170602185015.GB31147@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

This is a good news. Do you think to provide  network nic drivers 
enabled for realtime.?


Le 02/06/2017 à 20:50, Julia Cartwright a écrit :
> On Fri, Jun 02, 2017 at 06:15:31PM +0000, Hindman, Gavin wrote:
>> Hello everyone,
>>
>> I wanted to make you all aware that Intel is now maintaining a
>> preempt_rt enabled version of our 4.9LTS production kernel located
>> here: https://github.com/01org/linux-intel-4.9/wiki  Support is fairly
>> new, and doesn't extend much beyond integrating preempt_rt at this
>> point, but this is where we will host real-time related optimized
>> kernel configs for Intel platforms, and feature back-ports, etc. as
>> those emerge.
> Hey Gavin-
>
> Is there a reason why the "real-time related optimized kernel configs"
> don't make their home in an upstream RT release?
>
> I recall speaking with Thomas at the RTLWS in Graz about whether or not
> the rt-devel tree should hold rt-enabled/optimized configs, to which he
> said: "patches welcome".
>
> Thanks,
>
>     Julia
