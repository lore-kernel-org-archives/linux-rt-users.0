From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 3/3] MM: allow per-cpu vmstat_worker configuration
Date: Wed, 10 May 2017 11:34:26 -0400
Message-ID: <1494430466.29205.17.camel@redhat.com>
References: <20170503184007.174707977@redhat.com>
         <20170503184039.901336380@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170503184039.901336380@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2017-05-03 at 15:40 -0300, Marcelo Tosatti wrote:
> Following the reasoning on the last patch in the series,
> this patch allows configuration of the per-CPU vmstat worker:
> it allows the user to disable the per-CPU vmstat worker.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Is there ever a case where you would want to configure
this separately from the vmstat_threshold parameter?

What use cases are you trying to address?
