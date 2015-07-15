From: Xander Huff <xander.huff@ni.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
Date: Wed, 15 Jul 2015 10:59:25 -0500
Message-ID: <55A6835D.1000401@ni.com>
References: <5574633F.7090004@kernel.org> <1436391502-2604-1-git-send-email-xander.huff@ni.com> <20150714142846.GB21820@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, michal.simek@xilinx.com,
	soren.brinkmann@xilinx.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, joe.hershberger@ni.com,
	joshc@ni.com, nathan.sullivan@ni.com, jaeden.amero@ni.com,
	linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150714142846.GB21820@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 7/14/2015 9:28 AM, Sebastian Andrzej Siewior wrote:
> * Xander Huff | 2015-07-08 16:38:22 [-0500]:
>
>> drivers/iio/adc/xilinx-xadc-core.c | 35 ++++++++++++-----------------------
>> 1 file changed, 12 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>> index ce93bd8..b309ad3 100644
>> --- a/drivers/iio/adc/xilinx-xadc-core.c
>> +++ b/drivers/iio/adc/xilinx-xadc-core.c
>> @@ -1225,7 +1214,7 @@ static int xadc_probe(struct platform_device *pdev)
>> 	if (ret)
>> 		goto err_free_samplerate_trigger;
>>
>> -	ret = request_threaded_irq(irq, xadc->ops->interrupt_handler,
>> +	ret = request_threaded_irq(irq, 0,
>
> NULL not 0
> Other than that, it looks good. Thanks.
> If you managed to get this merged upstream then feel free to ping me and
> I pick this into -RT.
>
>> 				xadc->ops->threaded_interrupt_handler,
>> 				0, dev_name(&pdev->dev), indio_dev);
>> 	if (ret)
>
> Sebastian
>
Haven't got this merged in yet. I'm addressing another concern from Shubhrajyoti 
Datta and will include this change in my v3 I'll send out sometime next week, 
thanks!

-- 
Xander Huff
Staff Software Engineer
National Instruments
