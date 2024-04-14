import React, { Fragment } from "react";

export const Foods = ({ match }) => {
    return (
        <Fragment>
            Foods view
            <p>
                resutunt id is {match.params.restaurantsId}
            </p>
        </Fragment>
    )
}