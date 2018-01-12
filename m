From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Kernel config options that impact latency
Date: Fri, 12 Jan 2018 14:01:40 -0600
Message-ID: <dad7630d-e2f5-c966-d3fa-9a8124648ae8@ti.com>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: "Hindman, Gavin" <gavin.hindman@intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:44080 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965081AbeALUBm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Jan 2018 15:01:42 -0500
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1E9D96DC30@ORSMSX101.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On 01/04/2018 12:29 PM, Hindman, Gavin wrote:
> Since we seem to be in knowledge-sharing mode, is there an existing list of kernel config parameters,
 outside of those required to enable preempt_rt, known to impact or improve general system latency?
  I didn't find anything prowling the various wikis.
> 

You can pay attention on 
CONFIG_RCU_BOOST
CONFIG_RCU_NOCB_xxx

Also, as mentioned, disabling PM, especially CPU PM is helpful.
CONFIG_CPU_IDLE=n
CONFIG_CPU_FREQ=n
Note. you can also use CONFIG_GENERIC_IDLE_POLL_SETUP
and "nohlt" command line parameter, but you might hit overheating ;)

!!! And, of course, disable most of debug options unless you really need them. 


-- 
regards,
-grygorii
