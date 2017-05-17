From: Eric Nelson <eric@nelint.com>
Subject: Re: Question regarding RT patches for ARM
Date: Wed, 17 May 2017 07:45:39 -0700
Message-ID: <c0fc9f9b-ae0b-66d3-71c7-e2b98f6900e0@nelint.com>
References: <CAGgoGu6=EKCkzbZ0=i+4e+9rJUvxG-SUix1AQVch8VF=OmokVw@mail.gmail.com>
 <3aa42082.b247.15c0c29ca5e.Coremail.qiledexin@163.com>
 <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
 <646e1a43-78a7-3d04-ee29-1299b7d9d4d8@nelint.com>
 <CAGgoGu7z1KUve8G_Ld_Yk-1umDq1qO=HCw2vjMuU=YXqxzt0tA@mail.gmail.com>
 <CAGgoGu4LHrZJHzwBFgpEYCzBRtH24N_Y1UUspkoZJKPPdQmuvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: GuJiangfei <qiledexin@163.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-rt-users@vger.kernel.org
To: Fawad Lateef <fawadlateef@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGgoGu4LHrZJHzwBFgpEYCzBRtH24N_Y1UUspkoZJKPPdQmuvQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Fawad,

On 05/17/2017 06:40 AM, Fawad Lateef wrote:
> On 15 May 2017 at 16:20, Fawad Lateef <fawadlateef@gmail.com> wrote:
>> Hi Eric,
>> On 15 May 2017 at 16:12, Eric Nelson <eric@nelint.com> wrote:
>>> Hi Fawad,
>>>
>>>> 发自网易邮箱大师
>>>> On 05/15/2017 20:44, Fawad Lateef wrote:
>>>>
>>>> Hi All,
>>>>
>>>> I am working on custom i.MX6 quad hardware and using RT patches for
>>>> almost latest stable kernel 4.9 and facing some weird system stall OR
>>>> 'unhandled page fault - exceptions'.
>>>>
>>>
>>> I'm not sure about the unhandled page fault, but the stalls may be
>>> because of the SDMA driver.
>>>
>>> See this patch in the Freescale/NXP community for kernel 4.1:
>>> https://github.com/Freescale/meta-freescale/blob/master/recipes-kernel/linux/linux-fslc-imx-rt/0003-Work-around-CPU-stalls-in-the-imx-sdma-driver.patch
>>>
>>
>> Thanks for the patch link. I will give it a try.
> 
> Talked to hardware manufacturer and they applied the patch.
> 
> Still that SDMA is only used for NOR flash and only u-boot and its
> environment are stored in nor flash. So not sure if that is going to
> help in any case.
> 

SDMA is used for much more than NOR flash (SSI, USB, and sometimes
UARTs).

> So I would really like few more suggestions OR confirmations about ARM
> (cortex-A9 based imx6) (preemept)-RT support/patches are stable and
> can be used for final products.
> 

I don't have any experience with the RT patches on 4.9 or later
kernels, but do know that they're being used on i.MX6 with the
vendor kernels (3.10.x, 4.1.x).

I believe Alison Chaiken mentioned using them with 4.9 kernels:
http://elinux.org/images/4/42/IRQs-_the_Hard%2C_the_Soft%2C_the_Threaded_and_the_Preemptible.pdf
https://www.youtube.com/watch?v=-pehAzaP1eg&feature=youtu.be&list=PLbzoR-pLrL6pRFP6SOywVJWdEHlmQE51q

Regards,


Eric
