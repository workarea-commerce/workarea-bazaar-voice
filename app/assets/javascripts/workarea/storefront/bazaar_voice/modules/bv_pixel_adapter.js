/* eslint no-console: "off" */
/* global console */

/**
 * @namespace WORKAREA.bvPixelAdapter
 */
WORKAREA.analytics.registerAdapter('bvPixelAdapter', function () {
    'use strict';

    var sendTransactionEvent = function (transaction) {
            if (WORKAREA.analytics.debug) {
                console.log('Track BV transaction', transaction);
            }

            if (WORKAREA.environment.isTest) { return; }

            window.bvCallback = function (BV) {
                BV.pixel.trackTransaction(transaction);
            };
        },

        sendConversionEvent = function(conversion) {
            if (WORKAREA.analytics.debug) {
                console.log('Track BV transaction', arguments);
            }

            if (WORKAREA.environment.isTest) { return; }

            window.bvCallback = function (BV) {
                BV.pixel.trackConversion({
                    "type": conversion.type,
                    "label": conversion.label || '',
                    "value": conversion.value || ''
                });
            };
        };

    return {
        'checkoutOrderPlaced': function (payload) {
            var transaction = {
                'currency': payload.currency,
                'orderId': payload.id,
                'tax': payload.tax_total.toFixed(2),
                'total': payload.total_price.toFixed(2),
                'shipping': payload.shipping_total.toFixed(2),
                'items': _.map(payload.items, function (impression) {
                    return {
                        'price': impression.price.toFixed(2),
                        'quantity': impression.quantity,
                        'sku': impression.sku,
                        'category': impression.category
                    };
                })
            };

            sendTransactionEvent(transaction);
        },

        'productView': function (payload) {
            sendConversionEvent({
                'type': 'ProductDetail',
                'value': payload.id,
                'label': 'ProductPage'
            });
        },

        'addToCart': function (payload) {
            sendConversionEvent({
                'type': 'AddToCart',
                'value': payload.id
            });
        },

        'emailSignup': function () {
            sendConversionEvent({
                'type': 'emailSignUp',
                'value': 1,
                'label': 'Sign Up for Deals'
            });
        },
    };
});
